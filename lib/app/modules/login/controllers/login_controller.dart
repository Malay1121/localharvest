import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:speech_to_text/speech_to_text.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List userTypes = [
    AppStrings.consumer,
    AppStrings.farmer,
  ];
  String selectedUserType = AppStrings.consumer;
  void changeUserType(String userType) {
    selectedUserType = userType;
    update();
  }

  void login() async {
    if (validation()) {
      EasyLoading.show();
      Map<String, dynamic> userDetails = {
        "email": emailController.text,
        "password": generateMd5(passwordController.text),
        "userType": selectedUserType,
      };
      UserCredential? result =
          await DatabaseHelper.loginUser(data: userDetails);
      if (result != null) {
        Get.offAllNamed(userDetails["userType"] == AppStrings.farmer
            ? Routes.FARMER_HOME
            : Routes.HOME);
      }
      EasyLoading.dismiss();
    }
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
                  "email": "email address of the user",
                },
              ],
            );
            data = jsonDecode(
                data["candidates"][0]["content"]["parts"][0]["text"]);
            print(data);
            if (data["context"] == true) {
              emailController.text =
                  data["data"]["email"] ?? emailController.text;
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

  bool validation() {
    if (emailController.text.isEmpty || !validateEmail(emailController.text)) {
      showSnackbar(message: AppStrings.emailValidation);
      return false;
    } else if (passwordController.text.isEmpty) {
      showSnackbar(title: AppStrings.passwordValidation);
      return false;
    }
    return true;
  }
}
