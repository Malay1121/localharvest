import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';

class SplashController extends CommonController {
  bool firstTime = true;

  void checkLogin() async {
    var userData = readUserDetails();
    // print(userData);
    if (userData != null && userData != {}) {
      var user = await DatabaseHelper.loginUser(data: userData);
      // print(user);
      if (user != null) {
        firstTime = false;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkLogin();
    DatabaseHelper.getApis();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        var userData = readUserDetails();

        Get.offAndToNamed(!firstTime
            ? userData!["userType"] == AppStrings.farmer
                ? Routes.FARMER_HOME
                : Routes.HOME
            : Routes.ONBOARDING);
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
