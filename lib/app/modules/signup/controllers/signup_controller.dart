import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_harvest/app/helper/all_imports.dart';

class SignupController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

  void signUp() async {
    if (validation()) {
      EasyLoading.show();
      Map<String, dynamic> userDetails = {
        "fName": firstNameController.text,
        "lName": lastNameController.text,
        "email": emailAddressController.text,
        "phone": phoneController.text,
        "password": generateMd5(passwordController.text),
        "userType": selectedUserType,
      };
      await DatabaseHelper.createUser(data: userDetails);
    }
    EasyLoading.dismiss();
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
    if (firstNameController.text.isEmpty) {
      showSnackbar(message: AppStrings.nameValidation);
      return false;
    } else if (lastNameController.text.isEmpty) {
      showSnackbar(message: AppStrings.nameValidation);
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
