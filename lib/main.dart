import 'app/helper/all_imports.dart';

void main() {
  initializeSize(390, 844);
  initializeSpeech();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
