import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
        init: AddProductController(),
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
                        height: 24.h(context),
                      ),
                      Row(
                        children: [
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h(context),
                      ),
                      AppText(
                        text: AppStrings.newProduct,
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
                      GestureDetector(
                        onTap: () => controller.pickProductImage(),
                        child: Container(
                          width: 100.w(context),
                          height: 100.h(context),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            image: controller.edit &&
                                    controller.existingImage != ""
                                ? DecorationImage(
                                    image: NetworkImage(
                                      controller.existingImage,
                                    ),
                                    fit: BoxFit.cover)
                                : controller.productImage != null
                                    ? DecorationImage(
                                        image:
                                            FileImage(controller.productImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                          ),
                          child: controller.edit ||
                                  controller.productImage != null
                              ? !controller.edit
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
                                  : SizedBox()
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.icPlant,
                                      color: AppColors.primary,
                                      width: 30.w(context),
                                      height: 30.h(context),
                                    ),
                                    AppText(
                                      text: AppStrings.productImage,
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
                        hintText: AppStrings.productName,
                        controller: controller.productNameController,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Center(
                          child: SvgPicture.asset(
                            AppImages.icPlant,
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
                        hintText: AppStrings.productDescription,
                        controller: controller.productDescriptionController,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Center(
                          child: SvgPicture.asset(
                            AppImages.icPlant,
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
                        hintText: AppStrings.productPrice,
                        controller: controller.productPriceController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Center(
                          child: Icon(
                            Icons.attach_money,
                            color: AppColors.primary,
                            size: 24.h(context),
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxWidth: 32.w(context),
                          maxHeight: 24.h(context),
                        ),
                      ),
                      SizedBox(
                        height: 8.h(context),
                      ),
                      AppText(
                        text: "Per",
                        style: Styles.medium(
                          color: AppColors.fontDark,
                          fontSize: 16.t(context),
                        ),
                      ),
                      SizedBox(
                        height: 8.h(context),
                      ),
                      CommonTextField(
                        hintText: AppStrings.productQuantity,
                        keyboardType: TextInputType.number,
                        controller: controller.productQuantityController,
                        textInputAction: TextInputAction.next,
                        prefixIcon: Center(
                          child: Icon(
                            Icons.production_quantity_limits,
                            color: AppColors.primary,
                            size: 24.h(context),
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
                        text: AppStrings.addProduct,
                        onTap: () => controller.createProduct(),
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
