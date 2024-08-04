import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../helper/all_imports.dart';

class AddProductController extends CommonController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  File? productImage;
  bool edit = false;

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

  void createProduct() async {
    if (await validation()) {
      EasyLoading.show();
      Map<String, dynamic> productDetails = {
        "title": productNameController.text,
        "description": productDescriptionController.text,
        "price": double.parse(productPriceController.text),
        "quantity": double.parse(productQuantityController.text),
        "image": productImage,
        "farmerId": userDetails["uid"],
      };
      dynamic result;
      if (!edit) {
        result = await DatabaseHelper.createProduct(data: productDetails);
      } else {
        productDetails.addEntries({"id": product["id"]}.entries);
        productDetails["image"] = product["image"];
        result = await DatabaseHelper.editProduct(data: productDetails);
      }
      if (result != null) {
        Get.offAndToNamed(Routes.FARMER_HOME);
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
                  "price": "Price of the product per quantity",
                  "quantity": "Quantity of the product",
                  "title": "Name of the product sold by farmer",
                  "description": "A small description about the product",
                },
              ],
            );
            data = jsonDecode(
                data["candidates"][0]["content"]["parts"][0]["text"]);
            print(data);
            if (data["context"] == true) {
              productNameController.text =
                  data["data"]["title"] ?? productNameController.text;
              productPriceController.text =
                  data["data"]["price"] ?? productPriceController.text;
              productDescriptionController.text = data["data"]["description"] ??
                  productDescriptionController.text;
              productQuantityController.text =
                  data["data"]["quantity"] ?? productQuantityController.text;
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

  String existingImage = "";
  Map product = {};
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      Map productDetails = Get.arguments;
      product = productDetails;
      productQuantityController.text = productDetails["quantity"].toString();
      productPriceController.text = productDetails["price"].toString();
      productNameController.text = productDetails["title"];
      existingImage = productDetails["image"];
      edit = true;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    productImage = image != null ? File(image.path) : null;
    update();
  }

  void pickProductImage() {
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

  Future<bool> validation() async {
    if (edit == false &&
        (productImage == null || !(await productImage!.exists()))) {
      showSnackbar(message: AppStrings.profilePictureValidation);
      return false;
    }
    if (productNameController.text.isEmpty) {
      showSnackbar(message: AppStrings.commonValidation);
      return false;
    } else if (productDescriptionController.text.isEmpty) {
      showSnackbar(message: AppStrings.commonValidation);
      return false;
    } else if (productPriceController.text.isEmpty) {
      showSnackbar(message: AppStrings.commonValidation);
      return false;
    } else if (productQuantityController.text.isEmpty) {
      showSnackbar(message: AppStrings.commonValidation);
      return false;
    }
    return true;
  }
}
