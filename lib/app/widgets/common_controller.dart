import '../helper/all_imports.dart';

class CommonController extends GetxController {
  // Future<void> checkInternetConnection() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     // Display a "No Internet Connection" message
  //     showDialog(
  //       context: Get.context!,
  //       builder: (context) => AlertDialog(
  //         title: Text('No Internet Connection'),
  //         content: Text('Please check your internet connection and try again.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     // Perform the network request
  //     // ...
  //   }
  // }
  Widget statCard(
      {required String title,
      required String description,
      required String icon}) {
    return Container(
      width: 163.w(Get.context!),
      height: 67.h(Get.context!),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.stroke,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w(Get.context!),
          vertical: 12.h(Get.context!),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 35.w(Get.context!),
              height: 35.h(Get.context!),
            ),
            SizedBox(
              width: 16.w(Get.context!),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  style: Styles.bold(
                    color: AppColors.primary,
                    fontSize: 16.t(Get.context!),
                  ),
                  height: 21.h(Get.context!),
                ),
                AppText(
                  text: description,
                  style: Styles.bold(
                    color: AppColors.fontGrey,
                    fontSize: 14.t(Get.context!),
                  ),
                  height: 18.h(Get.context!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map userDetails = {};

  @override
  void onInit() {
    // print('loll');
    // checkInternetConnection();
    userDetails = readUserDetails() ?? {};

    super.onInit();
  }
}
