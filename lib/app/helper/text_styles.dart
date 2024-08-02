import 'all_imports.dart';

class Styles {
  static TextStyle medium({Color? color, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: dmSans,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bold({Color? color, double? fontSize}) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: dmSans,
      fontWeight: FontWeight.bold,
    );
  }
}
