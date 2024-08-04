import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../controllers/farmer_info_controller.dart';

class FarmerInfoView extends GetView<FarmerInfoController> {
  const FarmerInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarmerInfoController>(
        init: FarmerInfoController(),
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
                        text: AppStrings.fewMoreDetails,
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
                      CommonTextField(
                        hintText: AppStrings.experience,
                        controller: controller.experienceController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Center(
                          child: Icon(
                            Icons.work,
                            color: AppColors.primary,
                            size: 20.t(context),
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
                        hintText: AppStrings.freeLand,
                        controller: controller.freeLandController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Center(
                          child: Icon(
                            Icons.landscape,
                            color: AppColors.primary,
                            size: 20.t(context),
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
                        text: AppStrings.done,
                        onTap: () => controller.signUp(),
                        height: 50,
                        width: 342,
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
        });
  }
}
