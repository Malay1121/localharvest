import 'package:flutter_animator/flutter_animator.dart';
import 'package:local_harvest/app/helper/all_imports.dart';
import 'package:local_harvest/app/widgets/common_button.dart';
import 'package:local_harvest/app/widgets/common_text.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Image.asset(
            AppImages.onboardingBackground,
            width: 390.w(context),
            height: 844.h(context),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w(context),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 64.h(context),
                ),
                SlideInLeft(
                  child: Image.asset(
                    AppImages.transparentLogo,
                    width: 100.w(context),
                    height: 100.h(context),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: 24.h(context),
                ),
                AppText(
                  text: AppStrings.getConnectedToFreshLocalAffordableGroceries,
                  maxLines: null,
                  centered: true,
                  width: 318.w(context),
                  textAlign: TextAlign.center,
                  style: Styles.bold(
                    color: AppColors.fontDark,
                    fontSize: 28.t(context),
                  ),
                ),
                SizedBox(
                  height: 24.h(context),
                ),
                AppText(
                  text: AppStrings
                      .supportYourLocalFarmersCutOutTheMiddleManGettingTheFarmerYourselfABetterDeal,
                  style: Styles.medium(
                    color: AppColors.fontGrey,
                    fontSize: 16.t(context),
                  ),
                  centered: true,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  width: 274.w(context),
                  height: 63.h(context),
                ),
                SizedBox(
                  height: 31.h(context),
                ),
                Row(
                  children: [
                    SlideInLeft(
                      child: CommonButton(
                        text: AppStrings.signUp,
                        onTap: () => Get.toNamed(Routes.SIGNUP),
                        height: 53,
                        width: 166,
                      ),
                    ),
                    SizedBox(
                      width: 10.w(context),
                    ),
                    SlideInRight(
                      child: CommonButton(
                        text: AppStrings.logIn,
                        backgroundColor: Colors.transparent,
                        textColor: AppColors.primary,
                        onTap: () => Get.toNamed(Routes.LOGIN),
                        height: 53,
                        width: 166,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
