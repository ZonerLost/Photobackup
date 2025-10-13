
import 'package:photobackup/utils/file_indexes.dart';

class SizeConfig {
  SizeConfig._();

  static double? width;

  static double? height;

  static void setScreenSize(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
  }

  static double get screenWidth => width ?? 0.0;

  static double get screenHeight => height ?? 0.0;
}
