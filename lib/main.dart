import 'app/helper/all_imports.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD7Oyg_T6xHwXew1NUlUYCW58KH9f4hJY4",
          appId: "1:997946243567:android:4a08571efe1f70ca915e1a",
          messagingSenderId: "997946243567",
          projectId: "localharvest-app"));
  storage =
      FirebaseStorage.instanceFor(bucket: "gs://localharvest-app.appspot.com");
  initializeSize(390, 844);
  configureEasyLoading();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      alignment: Alignment.center,
      child: AppText(
        text: 'Error!\n${details.exception}',
        style: TextStyle(color: AppColors.fontDark),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      ),
    );
  };
  runApp(
    GetMaterialApp(
      title: "Application",
      builder: EasyLoading.init(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
