import 'package:flutter_animator/flutter_animator.dart';

import '../../../helper/all_imports.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: SlideInLeft(
              preferences: AnimationPreferences(
                duration: Duration(seconds: 2),
              ),
              child: Image.asset(
                AppImages.transparentLogo,
                fit: BoxFit.fitWidth,
                width: 150.w(context),
                height: 150.h(context),
              ),
            ),
          ),
        );
      },
    );
  }
}
