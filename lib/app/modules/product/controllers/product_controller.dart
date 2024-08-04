import 'package:local_harvest/app/helper/all_imports.dart';

class ProductController extends CommonController {
  Map product = {};
  int quantity = 0;

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

  void addToCart() async {
    dynamic result = await DatabaseHelper.addToCart(
      uid: userDetails["uid"],
      productId: product["id"],
      quantity: quantity,
    );
    if (result != null) {
      Get.toNamed(Routes.CART);
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
