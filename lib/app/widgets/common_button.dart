import 'package:local_harvest/app/helper/all_imports.dart';

import 'common_text.dart';

class CommonButton extends StatefulWidget {
  CommonButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.height = 48,
      this.width = 342,
      this.backgroundColor,
      this.textColor,
      this.border});
  String text;
  VoidCallback onTap;
  double height;
  double width;
  Color? backgroundColor;
  Color? textColor;
  Border? border;
  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.height.h(context),
        width: widget.width.w(context),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(61),
          border: widget.border,
        ),
        child: Center(
          child: AppText(
            text: widget.text,
            height: 24.h(context),
            centered: true,
            style: TextStyle(
              color: widget.textColor ?? AppColors.white,
              fontFamily: dmSans,
              fontWeight: FontWeight.w500,
              fontSize: 16.t(context),
            ),
          ),
        ),
      ),
    );
  }
}
