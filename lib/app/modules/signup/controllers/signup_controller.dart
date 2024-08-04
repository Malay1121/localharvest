import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SignupController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? profilePicture;

  List userTypes = [
    AppStrings.consumer,
    AppStrings.farmer,
  ];
  String selectedUserType = AppStrings.consumer;
  void changeUserType(String userType) {
    selectedUserType = userType;
    update();
  }

  List<Map> imageSources = [
    {
      "icon": Icons.camera_alt,
      "title": AppStrings.camera,
      "source": ImageSource.camera
    },
    {
      "icon": Icons.upload,
      "title": AppStrings.gallery,
      "source": ImageSource.gallery
    },
  ];

  void signUp() async {
    if (await validation()) {
      EasyLoading.show();

      Map<String, dynamic> userDetails = {
        "fName": firstNameController.text,
        "lName": lastNameController.text,
        "email": emailAddressController.text,
        "phone": phoneController.text,
        "password": generateMd5(passwordController.text),
        "userType": selectedUserType,
        "profilePicture": profilePicture,
      };
      if (selectedUserType == AppStrings.farmer) {
        Get.toNamed(Routes.FARMER_INFO, arguments: userDetails);
      } else {
        UserCredential? result =
            await DatabaseHelper.createUser(data: userDetails);
        if (result != null) {
          Get.offAllNamed(Routes.HOME);
        }
      }
    }
    EasyLoading.dismiss();
  }

  void selectImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    profilePicture = image != null ? File(image.path) : null;
    update();
  }

  void pickProfilePicture() {
    Get.bottomSheet(
      Container(
        height: 280.h(Get.context!),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w(Get.context!),
            vertical: 24.h(Get.context!),
          ),
          child: Column(
            children: [
              AppText(
                text: AppStrings.pickSource,
                style: Styles.bold(
                  color: AppColors.fontDark,
                  fontSize: 24.t(Get.context!),
                ),
                centered: true,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.h(Get.context!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (Map source in imageSources)
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        selectImage(source["source"]);
                      },
                      child: Container(
                        width: 166.w(Get.context!),
                        height: 140.h(Get.context!),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              source["icon"],
                              color: AppColors.primary,
                              size: 35.t(Get.context!),
                            ),
                            AppText(
                              text: source["title"],
                              style: Styles.medium(
                                color: AppColors.primary,
                                fontSize: 20.t(Get.context!),
                              ),
                              centered: true,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SpeechToText speech = SpeechToText();
  bool listening = false;
  void autoDetails() async {
    String words = "";
    bool available = await speech.initialize(
      onStatus: (status) {
        print(status);
        if (status == "done" || status == "notListening") {
          listening = false;
          update();
        } else if (status == "listening") {
          listening = true;
          update();
        }
      },
      onError: (errorNotification) {},
    );
    update();
    if (available) {
      speech.listen(
        listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
        partialResults: false,
        onResult: (result) async {
          words = result.recognizedWords;
          EasyLoading.show();
          try {
            Map data = await fetchDetailsAuto(
              words,
              [
                {
                  "fName": "First name of the user",
                  "lName": "Last name of the user",
                  "email": "email address of the user",
                  "phone": "Phone number of the user"
                },
              ],
            );
            data = jsonDecode(
                data["candidates"][0]["content"]["parts"][0]["text"]);
            print(data);
            if (data["context"] == true) {
              firstNameController.text =
                  data["data"]["fName"] ?? firstNameController.text;
              lastNameController.text =
                  data["data"]["lName"] ?? lastNameController.text;
              emailAddressController.text =
                  data["data"]["email"] ?? emailAddressController.text;
              phoneController.text =
                  data["data"]["phone"] ?? phoneController.text;
              update();
            }
          } catch (e) {
            EasyLoading.dismiss();
            throw e;
          }
          EasyLoading.dismiss();
        },
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> validation() async {
    if (profilePicture == null || !(await profilePicture!.exists())) {
      showSnackbar(message: AppStrings.profilePictureValidation);
      return false;
    }
    if (firstNameController.text.isEmpty) {
      showSnackbar(message: AppStrings.firstNameValidation);
      return false;
    } else if (lastNameController.text.isEmpty) {
      showSnackbar(message: AppStrings.lastNameValidation);
      return false;
    } else if (emailAddressController.text.isEmpty ||
        !validateEmail(emailAddressController.text)) {
      showSnackbar(message: AppStrings.emailValidation);
      return false;
    } else if (phoneController.text.isEmpty ||
        validatePhone(emailAddressController.text)) {
      showSnackbar(message: AppStrings.phoneValidation);
      return false;
    } else if (passwordController.text.isEmpty ||
        !validatePassword(passwordController.text)) {
      showSnackbar(
          title: AppStrings.passwordValidation,
          message: AppStrings.passwordErrorMessage);
      return false;
    }
    return true;
  }
}
