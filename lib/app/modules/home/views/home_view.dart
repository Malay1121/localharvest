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
                                "https://via.placeholder.com/52x52",
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
                    Container(
                      width: 163.w(context),
                      decoration: BoxDecoration(
                        color: AppColors.lightBG,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w(context),
                          vertical: 24.h(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20.w(context),
                                  height: 20.h(context),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://via.placeholder.com/52x52",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w(context),
                                ),
                                AppText(
                                  text: "Noa Bell",
                                  style: Styles.bold(
                                    color: AppColors.fontGrey,
                                    fontSize: 12.t(context),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h(context),
                            ),
                            Container(
                              width: 115.w(context),
                              height: 115.h(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://via.placeholder.com/115x115",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h(context)),
                            AppText(
                              text: "Noa’s Bell Peppers",
                              style: Styles.bold(
                                color: AppColors.fontDark,
                                fontSize: 14.t(context),
                              ),
                            ),
                            SizedBox(height: 2.h(context)),
                            AppText(
                              text: "1 kg, 3\$",
                              style: Styles.bold(
                                color: AppColors.secondary,
                                fontSize: 14.t(context),
                              ),
                            ),
                            Container(
                              width: 36.w(context),
                              height: 36.h(context),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                              child: SvgPicture.asset(
                                AppImages.icAdd,
                                width: 16.w(context),
                                height: 16.h(context),
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
