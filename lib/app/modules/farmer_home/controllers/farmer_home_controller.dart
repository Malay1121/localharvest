import 'package:local_harvest/app/helper/all_imports.dart';

class FarmerHomeController extends CommonController {
  Map<String, dynamic> userDetails = {};
  List<Map> products = [];

  void getProducts() async {
    userDetails = readUserDetails() ?? {};
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
