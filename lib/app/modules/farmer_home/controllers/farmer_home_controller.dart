import 'package:local_harvest/app/helper/all_imports.dart';

class FarmerHomeController extends CommonController {
  List<Map> products = [];

  void getProducts() async {
    products = await DatabaseHelper.getProducts(
      farmerId: userDetails["uid"],
    );
    update();
  }

  @override
  void onInit() {
    super.onInit();

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
