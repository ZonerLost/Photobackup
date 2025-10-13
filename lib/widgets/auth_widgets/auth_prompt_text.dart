import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photobackup/constants/app_colors.dart';

class KRichText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback? onActionTap;
  final TextStyle? textStyle;
  const KRichText({super.key, required this.normalText, required this.actionText, this.onActionTap, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: normalText,
                  style: textStyle ?? TextStyle(
                    color: AppColors.greyText,
                    fontSize: 14,
                  )),
              TextSpan(
                  text: actionText,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = onActionTap)
            ])));
  }
}
