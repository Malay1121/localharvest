import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:local_harvest/app/widgets/common_controller.dart';

class HomeController extends CommonController {
  Map<String, dynamic> userDetails = {};
  List<Map> products = [];

  void getProducts() async {
    products = await DatabaseHelper.getProducts();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    userDetails = readUserDetails() ?? {};
    getProducts();
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
