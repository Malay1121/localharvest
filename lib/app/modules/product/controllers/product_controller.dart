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

  Widget statCard(
      {required String title,
      required String description,
      required String icon}) {
    return Container(
      width: 163.w(Get.context!),
      height: 67.h(Get.context!),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.stroke,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w(Get.context!),
          vertical: 12.h(Get.context!),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 35.w(Get.context!),
              height: 35.h(Get.context!),
            ),
            SizedBox(
              width: 16.w(Get.context!),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  style: Styles.bold(
                    color: AppColors.primary,
                    fontSize: 16.t(Get.context!),
                  ),
                  height: 21.h(Get.context!),
                ),
                AppText(
                  text: description,
                  style: Styles.bold(
                    color: AppColors.fontGrey,
                    fontSize: 14.t(Get.context!),
                  ),
                  height: 18.h(Get.context!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
