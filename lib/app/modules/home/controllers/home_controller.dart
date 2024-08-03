import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:local_harvest/app/widgets/common_controller.dart';

class HomeController extends CommonController {
  Map<String, dynamic> userDetails = {};

  @override
  void onInit() {
    super.onInit();
    userDetails = readUserDetails() ?? {};
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
