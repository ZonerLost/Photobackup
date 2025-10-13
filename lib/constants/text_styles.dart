import 'package:photobackup/utils/file_indexes.dart';

class KText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? decorationColor;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? textStyle;

  const KText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textDecoration,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow,
    this.textStyle,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = color ?? Theme.of(context).textTheme.titleLarge!.color;
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle ?? kTextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: defaultColor,
        textDecoration: textDecoration ?? TextDecoration.none,
        decorationColor: decorationColor ?? AppColors.blackColor
      ),
    );
  }
}

TextStyle kTextStyle({double? fontSize, FontWeight? fontWeight, BuildContext? context,
  Color? color,TextDecoration? textDecoration,Color? decorationColor}) {
  return GoogleFonts.outfit(
      textStyle: TextStyle(
        decoration: textDecoration?? TextDecoration.none,
        fontSize:  fontSize?? 16,
        fontWeight: fontWeight??FontWeight.w400,
        color: color??Theme.of(context!).textTheme.titleLarge!.color,
        decorationColor: decorationColor??AppColors.blackColor
      )
  );
}

