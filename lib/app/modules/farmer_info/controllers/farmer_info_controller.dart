import 'package:speech_to_text/speech_to_text.dart';

import '../../../helper/all_imports.dart';

class FarmerInfoController extends GetxController {
  TextEditingController experienceController = TextEditingController();
  TextEditingController freeLandController = TextEditingController();

  Map userDetails = {};

  void signUp() async {
    Map<String, dynamic> extraDetails = {
      "experience": double.parse(experienceController.text),
      "freeLand": double.parse(freeLandController.text),
      "sales": 0,
      "review": 4,
    };
    userDetails.addEntries(extraDetails.entries);
    UserCredential? result = await DatabaseHelper.createUser(
        data: userDetails as Map<String, dynamic>);
    if (result != null) {
      Get.offAllNamed(Routes.FARMER_HOME);
    }
  }

  SpeechToText speech = SpeechToText();
  bool listening = false;
  void autoDetails() async {
    String words = "";
    bool available = await speech.initialize(
      onStatus: (status) {
        print(status);
        if (status == "done" || status == "notListening") {
          listening = false;
          update();
        } else if (status == "listening") {
          listening = true;
          update();
        }
      },
      onError: (errorNotification) {},
    );
    update();
    if (available) {
      speech.listen(
        listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
        partialResults: false,
        onResult: (result) async {
          words = result.recognizedWords;
          EasyLoading.show();
          try {
            Map data = await fetchDetailsAuto(
              words,
              [
                {
                  "experience":
                      "Number of years of experience the farmer has in farming. Give the output in double",
                  "freeLand":
                      "Amount of land available to grow crops for the user.  Give the output in int",
                },
              ],
            );
            data = jsonDecode(
                data["candidates"][0]["content"]["parts"][0]["text"]);
            print(data);
            if (data["context"] == true) {
              experienceController.text =
                  data["data"]["experience"] ?? experienceController.text;
              freeLandController.text =
                  data["data"]["freeLand"] ?? freeLandController.text;
              update();
            }
          } catch (e) {
            EasyLoading.dismiss();
            throw e;
          }
          EasyLoading.dismiss();
        },
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      userDetails = Get.arguments;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool validation() {
    if (experienceController.text.isEmpty) {
      showSnackbar(message: AppStrings.commonValidation);
      return false;
    } else if (freeLandController.text.isEmpty) {
      showSnackbar(title: AppStrings.commonValidation);
      return false;
    }
    return true;
  }
}
