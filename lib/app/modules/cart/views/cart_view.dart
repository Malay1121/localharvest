import 'package:local_harvest/app/helper/all_imports.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.h(context),
                      left: 24.w(context),
                      right: 24.w(context),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: AppStrings.cart,
                              style: Styles.bold(
                                  color: AppColors.fontDark,
                                  fontSize: 20.t(context)),
                              height: 44.h(context),
                              centered: true,
                            ),
                          ],
                        ),
                        GestureDetector(
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
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        for (Map product in controller.products)
                          Column(
                            children: [
                              SizedBox(
                                height: 24.h(context),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w(context),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        product["productDetails"]["image"],
                                        width: 42.w(context),
                                        height: 42.h(context),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16.w(context),
                                    ),
                                    Column(
                                      children: [
                                        AppText(
                                          text: product["productDetails"]
                                                  ["farmerDetails"]["fName"] +
                                              "'s " +
                                              product["productDetails"]
                                                  ["title"],
                                          style: Styles.bold(
                                            color: AppColors.fontDark,
                                            fontSize: 16.t(context),
                                          ),
                                          width: 155.w(context),
                                        ),
                                        SizedBox(
                                          height: 4.h(context),
                                        ),
                                        AppText(
                                          text:
                                              "${product["productDetails"]["quantity"]}kg, ${product["productDetails"]["price"]}\$",
                                          style: Styles.bold(
                                            color: AppColors.secondary,
                                            fontSize: 16.t(context),
                                          ),
                                          width: 155.w(context),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        product["quantity"]--;
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
                                      text: product["quantity"].toString(),
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
                                        product["quantity"]++;
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
                              ),
                              SizedBox(
                                height: 16.h(context),
                              ),
                              Container(
                                width: 390.w(context),
                                height: 1,
                                color: AppColors.stroke,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w(context),
                      vertical: 24.h(context),
                    ),
                    child: CommonButton(
                      text: AppStrings.checkout,
                      onTap: () => controller.checkout(),
                      height: 50,
                      width: 342,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
