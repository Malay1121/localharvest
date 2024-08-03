import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../helper/all_imports.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField({
    super.key,
    required this.hintText,
    this.height = 45,
    this.width = 342,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.maxLines = 1,
    this.prefixIconConstraints,
  });
  String hintText;
  double? width;
  double? height;
  Widget? prefixIcon;
  TextEditingController? controller;
  bool obscureText;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  int? maxLines;
  BoxConstraints? prefixIconConstraints;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  void speak() {
    if (!listening) {
      getText();
    }
  }

  Future<String> getText() async {
    String result = "";
    setState(() {
      listening = true;
    });

    SpeechRecognitionResult r = await speechToText.listen(
        listenOptions: SpeechListenOptions(listenMode: ListenMode.dictation),
        partialResults: false,
        onResult: (res) {
          setState(() {
            result = res.recognizedWords;
            if (widget.controller != null) widget.controller!.text += result;
            listening = false;
          });
        });

    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width?.w(context),
      height: widget.height?.h(context),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          fillColor: AppColors.white,
          filled: true,
          hintText: widget.hintText,
          suffixIcon: GestureDetector(
            onTap: () => speak(),
            child: Icon(
              listening ? Icons.stop : Icons.mic,
              color: AppColors.primary,
              size: 16.t(context),
            ),
          ),
          hintStyle: Styles.medium(
            color: AppColors.fontGrey,
          ),
          prefixIconConstraints: widget.prefixIconConstraints,
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(67),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(67),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(67),
            borderSide: BorderSide(
              color: AppColors.stroke,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(67),
            borderSide: BorderSide(
              color: AppColors.stroke,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
