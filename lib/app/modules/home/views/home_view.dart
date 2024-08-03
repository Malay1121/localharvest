import 'package:local_harvest/app/helper/all_imports.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Container(
              height: 262.h(context),
              width: 844.w(context),
              decoration: BoxDecoration(
                color: AppColors.lightBG,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(180),
                  bottomRight: Radius.circular(180),
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h(context),
                  horizontal: 24.w(context),
                ),
                child: Column(
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
                    CommonTextField(
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
                    Wrap(
                      spacing: 16.w(context),
                      runSpacing: 16.h(context),
                      children: [
                        for (Map product in controller.products)
                          CommonProduct(
                            id: product["id"],
                            farmerFirstName:
                                product["farmerDetails"]["fName"] ?? "",
                            farmerLastName:
                                product["farmerDetails"]["lName"] ?? "",
                            farmerImage: product["farmerDetails"]
                                    ["profilePicture"] ??
                                "",
                            productName: product["title"] ?? "",
                            image: product["image"] ?? "",
                            price: double.parse(
                                (product["price"] ?? 1).toString()),
                            quantity: double.parse(
                                (product["quantity"] ?? 1).toString()),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
