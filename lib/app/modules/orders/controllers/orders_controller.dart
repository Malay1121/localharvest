import 'package:get/get.dart';
import 'package:local_harvest/app/helper/all_imports.dart';

class OrdersController extends CommonController {
  List<Map> orders = [];

  void getOrders() async {
    print(userDetails["uid"]);
    orders = await DatabaseHelper.getOrders(uid: userDetails["uid"]);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
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
