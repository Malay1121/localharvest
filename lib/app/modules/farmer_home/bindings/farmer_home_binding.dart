import 'package:get/get.dart';

import '../controllers/farmer_home_controller.dart';

class FarmerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmerHomeController>(
      () => FarmerHomeController(),
    );
  }
}
