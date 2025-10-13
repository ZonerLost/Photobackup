
import 'package:photobackup/utils/file_indexes.dart';

Widget kTextButton( {
  Color? color,
  Function()? onPressed,
  String? btnText,
  Widget? widget,
  Color? textColor,
  Color? borderColor,
  double? height,
  double ? width,
  double ? borderRadius,
  double ? fontSize,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height?? 55,
      width: width,
      alignment: Alignment.center,
      padding:  const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: color ?? AppColors.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius??10),
        border: Border.all(color: borderColor?? Colors.transparent),
      ),
      child: widget?? KText(
        text: btnText!,
        textAlign: TextAlign.center,
        fontSize: fontSize??15,
            fontWeight: FontWeight.w500,
            color: textColor??AppColors.whiteColor),),
  );
}


Widget kMaterialButton({
  required final Function() onTap,
  required final String btnText,
  final Color? btnColor,
  final double? borderRadius,
  final double? width,
  final Color? textColor,
}){
  return MaterialButton(
    onPressed: onTap,
    color: btnColor?? AppColors.whiteColor,
    height: 55,
    minWidth: width?? double.infinity,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius?? 10.0),
    ),
    child:  KText( text: btnText, textAlign: TextAlign.center, fontWeight: FontWeight.w500,color: textColor?? AppColors.whiteColor,),
  );
}


Widget genreButton({
  required String text,
  required var onTap,
  required Color color,
  Color? textColor,
  double? textSize,
  FontWeight? fontWeight,
  double? width,
  double? height,
  Color? sideColor,
}) {
  return MaterialButton(
    onPressed: onTap,
    color: color,
    textColor: textColor ?? Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: BorderSide(color: sideColor ?? Colors.transparent, width: 2.0),
    ),
    height: height ?? 30,
    minWidth: width,
    child:  KText(text: text,
        textStyle: kTextStyle(
          fontSize: textSize ?? 14.0,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor ?? Colors.white,
        )),
  );
}