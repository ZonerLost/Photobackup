import 'package:photobackup/utils/file_indexes.dart';

class GetTextField extends StatelessWidget {
  final BuildContext context;
  final String? hintText;
  final String? prefixIcon;
  final Widget? suffixIcon;
  final bool? showSuffixIcon;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;
  final Function()? suffixOnTap;
  final Function()? fieldOnTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? obSecureText;
  final bool? readOnly;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Color? borderColor;
  final int? maxLines;
  final double? verticalPadding;
  final Color? cursorColor;

  const GetTextField({super.key,
    required this.context,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.obSecureText,
    this.suffixOnTap,
    this.onChanged,
    this.focusNode,
    this.readOnly,
    this.borderColor,
    this.maxLines,
    this.verticalPadding,
    this.fieldOnTap, this.suffixWidget, this.cursorColor, this.showSuffixIcon = false ,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly !=null ?true:false,
      validator: validator,
      controller: controller,
      cursorColor: cursorColor ?? AppColors.greyColor,
      maxLines: maxLines?? 1,
      style: kTextStyle( fontSize: 15.0,context: context),
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction??TextInputAction.next,
      obscureText: obSecureText??false,
      onTapOutside: (event) {context.dismissKeyBoard();},
      onChanged: onChanged,
      onTap: fieldOnTap?? (){},

      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon!=null? showSvgIconWidget(iconPath: prefixIcon!,height: 20,width: 25,color: AppColors.greyColor):null,
        prefixIconConstraints: const BoxConstraints(
          minHeight: 20,
          minWidth: 35,
        ),
        suffixIcon: showSuffixIcon == true ? suffixIcon : null,
        // suffix: suffixWidget,
        contentPadding:  EdgeInsets.symmetric(horizontal:  15,vertical: verticalPadding??15),
        hintStyle: kTextStyle(color: Colors.grey, fontSize: 15.0),
        filled: true,
        isDense: true,
        fillColor: AppColors.whiteColor,
        errorStyle: kTextStyle(color: Colors.red, fontSize: 11.0),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.red,),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: Colors.red,),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:  BorderSide(color: borderColor?? AppColors.greyColor,),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:   BorderSide(color: borderColor?? AppColors.greyColor,),
        ),
      ),
    );
  }
}

