import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';

class CartController extends CommonController {
  List<Map> products = [];

  void getCart() async {
    products = await DatabaseHelper.getCart(uid: userDetails["uid"]);
    update();
  }

  void checkout() async {
    EasyLoading.show();
    dynamic result = await DatabaseHelper.checkout(
        uid: userDetails["uid"], products: products);
    if (result != null) {
      Get.offAndToNamed(Routes.HOME);
      showSnackbar(
          title: "Order received", message: "Farmer will contact you shortly!");
    }
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    super.onInit();
    getCart();
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
