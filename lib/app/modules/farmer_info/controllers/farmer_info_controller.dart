import '../../../helper/all_imports.dart';

class FarmerInfoController extends GetxController {
  TextEditingController experienceController = TextEditingController();
  TextEditingController freeLandController = TextEditingController();

  Map userDetails = {};

  void signUp() async {
    Map<String, dynamic> extraDetails = {
      "experience": double.parse(experienceController.text),
      "freeLand": double.parse(freeLandController.text),
      "sales": 0,
      "review": 4,
    };
    userDetails.addEntries(extraDetails.entries);
    UserCredential? result = await DatabaseHelper.createUser(
        data: userDetails as Map<String, dynamic>);
    if (result != null) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      userDetails = Get.arguments;
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

  bool validation() {
    if (experienceController.text.isEmpty) {
      showSnackbar(message: AppStrings.commonValidation);
      return false;
    } else if (freeLandController.text.isEmpty) {
      showSnackbar(title: AppStrings.commonValidation);
      return false;
    }
    return true;
  }
}
