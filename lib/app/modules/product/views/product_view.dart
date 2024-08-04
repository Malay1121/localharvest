import 'package:local_harvest/app/helper/all_imports.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      init: ProductController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 376.h(context),
                        width: 390.w(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(170),
                            bottomRight: Radius.circular(170),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              controller.product["image"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 24.h(context),
                        left: 24.w(context),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 44.w(context),
                            height: 44.h(context),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                              border: Border.all(
                                color: Color(0xFFF1F1F5),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColors.fontDark,
                              size: 15.t(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w(context),
                      vertical: 24.h(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppText(
                              text: controller.product["title"],
                              style: Styles.bold(
                                color: AppColors.fontDark,
                                fontSize: 24.t(context),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.quantity--;
                                controller.update();
                              },
                              child: Container(
                                width: 36.w(context),
                                height: 36.h(context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightBG,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.lightGrey,
                                  size: 24.t(context),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.w(context),
                            ),
                            AppText(
                              text: controller.quantity.toString(),
                              style: Styles.bold(
                                color: AppColors.fontDark,
                                fontSize: 18.t(context),
                              ),
                            ),
                            SizedBox(
                              width: 16.w(context),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.quantity++;
                                controller.update();
                              },
                              child: Container(
                                width: 36.w(context),
                                height: 36.h(context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                  size: 24.t(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.h(context),
                        ),
                        AppText(
                          text:
                              "${controller.product["quantity"]}kg, ${controller.product["price"]}\$",
                          style: Styles.bold(
                            color: AppColors.secondary,
                            fontSize: 18.t(context),
                          ),
                        ),
                        SizedBox(
                          height: 26.h(context),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 80.w(context),
                              height: 80.h(context),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.product["farmerDetails"]
                                        ["profilePicture"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 14.w(context),
                            ),
                            Column(
                              children: [
                                AppText(
                                  text:
                                      "${AppStrings.fulfilledBy}: ${controller.product["farmerDetails"]["fName"]} ${controller.product["farmerDetails"]["lName"]}",
                                  style: Styles.bold(
                                    color: AppColors.fontDark,
                                    fontSize: 18.t(context),
                                  ),
                                  width: 246.w(context),
                                  height: 24.h(context),
                                ),
                                SizedBox(
                                  height: 3.h(context),
                                ),
                                AppText(
                                  text: controller.product["description"] ??
                                      "Hello friend! I’m sure you’ll love the awesome taste of my crops!",
                                  style: Styles.bold(
                                    color: AppColors.fontGrey,
                                    fontSize: 14.t(context),
                                  ),
                                  maxLines: 2,
                                  width: 246.w(context),
                                  height: 36.h(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12.h(context),
                        ),
                        Wrap(
                          spacing: 16.w(context),
                          runSpacing: 16.h(context),
                          children: [
                            controller.statCard(
                              title: "100%",
                              description: AppStrings.organic,
                              icon: AppImages.icOrganic,
                            ),
                            controller.statCard(
                              title:
                                  "${controller.product["farmerDetails"]["experience"]} Years",
                              description: AppStrings.farmingExp,
                              icon: AppImages.icExperience,
                            ),
                            controller.statCard(
                              title:
                                  "${controller.product["farmerDetails"]["review"]}",
                              description: AppStrings.reviews,
                              icon: AppImages.icStar,
                            ),
                            controller.statCard(
                              title:
                                  "${controller.product["farmerDetails"]["sales"]}kg",
                              description: AppStrings.lifetimeSales,
                              icon: AppImages.icSales,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.h(context),
                        ),
                        CommonButton(
                          text: AppStrings.addToCart,
                          onTap: () => controller.addToCart(),
                          height: 50,
                          width: 342,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
