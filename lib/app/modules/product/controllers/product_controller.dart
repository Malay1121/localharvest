import 'package:local_harvest/app/helper/all_imports.dart';

class ProductController extends GetxController {
  Map product = {};

  void getProductDetails() async {
    if (Get.arguments != null) {
      Map arguments = Get.arguments;
      if (arguments["data"] != null) {
        product = arguments["data"];
      } else {
        product = await DatabaseHelper.getProduct(id: arguments["productId"]);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProductDetails();
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
