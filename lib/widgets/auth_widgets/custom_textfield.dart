import 'package:photobackup/components/k_text_fields.dart';
import 'package:photobackup/utils/file_indexes.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String hintText;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final bool? showSuffixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  const CustomTextField(
      {super.key,
      this.obscureText,
      required this.title,
      this.controller,
      required this.hintText,
      this.textInputAction,
      this.showSuffixIcon,
      this.suffixIcon,
        this.validator,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        4.height,
        GetTextField(
          controller: controller,
          obSecureText: obscureText,
          textInputAction: textInputAction,
          context: context,
          hintText: hintText,
          cursorColor: AppColors.primaryColor,
          borderColor: AppColors.lightGreyColor,
          showSuffixIcon: showSuffixIcon ?? false,
          suffixIcon: showSuffixIcon == true ? suffixIcon : null,
          validator: validator,
        ),
      ],
    );
  }
}
