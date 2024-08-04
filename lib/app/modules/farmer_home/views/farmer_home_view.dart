import 'package:local_harvest/app/helper/all_imports.dart';

import '../controllers/farmer_home_controller.dart';

class FarmerHomeView extends GetView<FarmerHomeController> {
  const FarmerHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarmerHomeController>(
        init: FarmerHomeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h(context),
                    horizontal: 24.w(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44.w(context),
                            height: 44.h(context),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.userDetails["profilePicture"],
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 11.w(context),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: greet(),
                                style: Styles.medium(
                                  color: AppColors.fontGrey,
                                  fontSize: 12.t(context),
                                ),
                                height: 16.h(context),
                              ),
                              AppText(
                                text:
                                    "${controller.userDetails["fName"]} ${controller.userDetails["lName"]}",
                                style: Styles.medium(
                                  color: AppColors.fontDark,
                                  fontSize: 16.t(context),
                                ),
                                height: 21.h(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h(context),
                      ),
                      SizedBox(
                        height: 12.h(context),
                      ),
                      Wrap(
                        spacing: 16.w(context),
                        runSpacing: 16.h(context),
                        children: [
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.ORDERS),
                            child: controller.statCard(
                              title: controller.orders.toString(),
                              description: AppStrings.orders,
                              icon: AppImages.icOrganic,
                            ),
                          ),
                          controller.statCard(
                            title:
                                "${controller.userDetails["experience"]} Years",
                            description: AppStrings.farmingExp,
                            icon: AppImages.icExperience,
                          ),
                          controller.statCard(
                            title: "${controller.userDetails["review"]}",
                            description: AppStrings.reviews,
                            icon: AppImages.icStar,
                          ),
                          controller.statCard(
                            title: "${controller.userDetails["sales"]}kg",
                            description: AppStrings.lifetimeSales,
                            icon: AppImages.icSales,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonButton(
                            text: AppStrings.newProduct,
                            onTap: () => Get.toNamed(
                              Routes.ADD_PRODUCT,
                            ),
                            width: 150.w(context),
                            height: 40.h(context),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h(context),
                      ),
                      CommonTextField(
                        controller: controller.searchController,
                        hintText: AppStrings.search,
                        prefixIcon: Center(
                          child: SvgPicture.asset(
                            AppImages.icSearch,
                            color: AppColors.primary,
                            width: 13.5.w(context),
                            height: 13.5.h(context),
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxWidth: 32.w(context),
                          maxHeight: 13.5.h(context),
                        ),
                      ),
                      SizedBox(
                        height: 24.h(context),
                      ),
                      controller.products.isEmpty
                          ? AppText(
                              text: AppStrings.noProductsListedYet,
                              style: Styles.medium(
                                color: AppColors.fontGrey,
                                fontSize: 16.t(context),
                              ),
                            )
                          : Wrap(
                              spacing: 16.w(context),
                              runSpacing: 16.h(context),
                              children: [
                                for (Map product in controller.products)
                                  GestureDetector(
                                    onLongPress: () {
                                      print(product);
                                    },
                                    child: CommonProduct(
                                      id: product["id"],
                                      farmerFirstName: product["farmerDetails"]
                                              ["fName"] ??
                                          "",
                                      farmerLastName: product["farmerDetails"]
                                              ["lName"] ??
                                          "",
                                      farmerImage: product["farmerDetails"]
                                              ["profilePicture"] ??
                                          "",
                                      productName: product["title"] ?? "",
                                      image: product["image"] ?? "",
                                      price: double.parse(
                                          (product["price"] ?? 1).toString()),
                                      quantity: double.parse(
                                          (product["quantity"] ?? 1)
                                              .toString()),
                                      data: product,
                                      edit: true,
                                      uid: controller.userDetails["uid"],
                                    ),
                                  ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
