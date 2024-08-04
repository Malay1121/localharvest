import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:local_harvest/app/widgets/common_farmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(
                children: [
                  Container(
                    height: 230.h(context),
                    width: 844.w(context),
                    decoration: BoxDecoration(
                      color: AppColors.lightBG,
                      borderRadius: BorderRadius.only(
                          // bottomLeft: Radius.circular(180),
                          // bottomRight: Radius.circular(180),
                          ),
                    ),
                  ),
                  Padding(
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
                            Spacer(),
                            GestureDetector(
                              onTap: () => Get.toNamed(Routes.CART),
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
                                  Icons.shopping_cart_outlined,
                                  color: AppColors.fontDark,
                                  size: 15.t(context),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24.h(context),
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
                          onChanged: (p0) => controller.onChange(p0),
                        ),
                        SizedBox(
                          height: 28.h(context),
                        ),
                        Container(
                          width: 342.w(context),
                          height: 50.h(context),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(67),
                          ),
                          child: Row(
                            children: [
                              for (String userType in controller.categories)
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.changeUserType(userType),
                                    child: Container(
                                      // width: 171.w(context),
                                      height: 50.h(context),
                                      decoration: BoxDecoration(
                                        color: userType ==
                                                controller.selectedCategory
                                            ? AppColors.primary
                                            : AppColors.lightBG,
                                        borderRadius: BorderRadius.circular(67),
                                      ),
                                      child: Center(
                                        child: AppText(
                                          text: userType,
                                          style: Styles.medium(
                                            color: userType ==
                                                    controller.selectedCategory
                                                ? AppColors.lightBG
                                                : AppColors.primary,
                                            fontSize: 18.t(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 28.h(context),
                        ),
                        (controller.selectedCategory == AppStrings.farmers &&
                                    controller.farmers.isEmpty) ||
                                (controller.selectedCategory ==
                                        AppStrings.products &&
                                    controller.products.isEmpty)
                            ? CircularProgressIndicator(
                                color: AppColors.primary,
                              )
                            : SizedBox(),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            child: Wrap(
                              spacing: 16.w(context),
                              runSpacing: 16.h(context),
                              children: [
                                for (Map product in controller.filteredData)
                                  controller.selectedCategory ==
                                          AppStrings.products
                                      ? CommonProduct(
                                          id: product["id"],
                                          farmerFirstName:
                                              product["farmerDetails"]
                                                      ["fName"] ??
                                                  "",
                                          farmerLastName:
                                              product["farmerDetails"]
                                                      ["lName"] ??
                                                  "",
                                          farmerImage: product["farmerDetails"]
                                                  ["profilePicture"] ??
                                              "",
                                          productName: product["title"] ?? "",
                                          image: product["image"] ?? "",
                                          price: double.parse(
                                              (product["price"] ?? 1)
                                                  .toString()),
                                          quantity: double.parse(
                                              (product["quantity"] ?? 1)
                                                  .toString()),
                                          data: product,
                                          uid: controller.userDetails["uid"],
                                        )
                                      : CommonFarmer(
                                          id: product["uid"],
                                          firstName: product["fName"],
                                          lastName: product["lName"],
                                          image: product["profilePicture"],
                                          sales: product["sales"],
                                          data: product,
                                        ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
