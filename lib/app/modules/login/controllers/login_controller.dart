import 'package:local_harvest/app/helper/all_imports.dart';

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
      await DatabaseHelper.loginUser(data: userDetails);
      EasyLoading.dismiss();
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
