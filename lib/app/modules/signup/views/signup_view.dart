import 'package:flutter_animator/flutter_animator.dart';
import 'package:local_harvest/app/helper/all_imports.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.lightBG,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w(context),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 34.h(context),
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
                      text: AppStrings.signUp,
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
                          for (String userType in controller.userTypes)
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    controller.changeUserType(userType),
                                child: Container(
                                  // width: 171.w(context),
                                  height: 50.h(context),
                                  decoration: BoxDecoration(
                                    color:
                                        userType == controller.selectedUserType
                                            ? AppColors.primary
                                            : AppColors.lightBG,
                                    borderRadius: BorderRadius.circular(67),
                                  ),
                                  child: Center(
                                    child: AppText(
                                      text: userType,
                                      style: Styles.medium(
                                        color: userType ==
                                                controller.selectedUserType
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
                      height: 16.h(context),
                    ),
                    GestureDetector(
                      onTap: () => controller.pickProfilePicture(),
                      child: Container(
                        width: 100.w(context),
                        height: 100.h(context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          image: controller.profilePicture != null
                              ? DecorationImage(
                                  image: FileImage(controller.profilePicture!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.profilePicture != null
                            ? Center(
                                child: Container(
                                  width: 40.w(context),
                                  height: 40.h(context),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.white,
                                    size: 18.t(context),
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.icProfile,
                                    color: AppColors.primary,
                                    width: 30.w(context),
                                    height: 30.h(context),
                                  ),
                                  AppText(
                                    text: AppStrings.profilePicture,
                                    style: Styles.medium(
                                      color: AppColors.primary,
                                      fontSize: 12.t(context),
                                    ),
                                    centered: true,
                                    textAlign: TextAlign.center,
                                    width: 80.w(context),
                                    maxLines: null,
                                  )
                                ],
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.firstName,
                      controller: controller.firstNameController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Center(
                        child: SvgPicture.asset(
                          AppImages.icProfile,
                          color: AppColors.primary,
                          width: 24.w(context),
                          height: 24.h(context),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 32.w(context),
                        maxHeight: 24.h(context),
                      ),
                    ),
                    SizedBox(
                      height: 16.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.lastName,
                      controller: controller.lastNameController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Center(
                        child: SvgPicture.asset(
                          AppImages.icProfile,
                          color: AppColors.primary,
                          width: 24.w(context),
                          height: 24.h(context),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 32.w(context),
                        maxHeight: 24.h(context),
                      ),
                    ),
                    SizedBox(
                      height: 16.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.emailAddress,
                      controller: controller.emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Center(
                        child: SvgPicture.asset(
                          AppImages.icEmail,
                          color: AppColors.primary,
                          width: 24.w(context),
                          height: 24.h(context),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 32.w(context),
                        maxHeight: 24.h(context),
                      ),
                    ),
                    SizedBox(
                      height: 16.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.phoneNumber,
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Center(
                        child: SvgPicture.asset(
                          AppImages.icPhone,
                          color: AppColors.primary,
                          width: 24.w(context),
                          height: 24.h(context),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 32.w(context),
                        maxHeight: 24.h(context),
                      ),
                    ),
                    SizedBox(
                      height: 16.h(context),
                    ),
                    CommonTextField(
                      hintText: AppStrings.password,
                      controller: controller.passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      prefixIcon: Center(
                        child: SvgPicture.asset(
                          AppImages.icLock,
                          color: AppColors.primary,
                          width: 24.w(context),
                          height: 24.h(context),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 32.w(context),
                        maxHeight: 24.h(context),
                      ),
                    ),
                    SizedBox(
                      height: 48.h(context),
                    ),
                    Pulse(
                      child: CommonButton(
                        text: controller.listening
                            ? AppStrings.listening
                            : AppStrings.autoFillBySpeech,
                        onTap: () => controller.autoDetails(),
                        height: 50,
                        width: 342,
                        backgroundColor: Colors.transparent,
                        textColor: AppColors.primary,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h(context),
                    ),
                    CommonButton(
                      text: AppStrings.signUp,
                      onTap: () => controller.signUp(),
                      height: 50,
                      width: 342,
                    ),
                    SizedBox(
                      height: 48.h(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: "${AppStrings.alreadyHaveAnAccount} ",
                          style: Styles.medium(
                            color: AppColors.fontDark,
                            fontSize: 16.t(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.offAndToNamed(Routes.LOGIN),
                          child: AppText(
                            text: AppStrings.logIn,
                            style: Styles.medium(
                                color: AppColors.primary,
                                fontSize: 16.t(context)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 48.h(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
