import 'package:get/get.dart';

import '../controllers/farmer_info_controller.dart';

class FarmerInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmerInfoController>(
      () => FarmerInfoController(),
    );
  }
}
