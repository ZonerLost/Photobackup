import 'package:flutter/material.dart';
import 'package:photobackup/constants/app_colors.dart';
import 'package:photobackup/constants/text_styles.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onViewAll;
  const CustomRow({super.key, required this.title,required this.subtitle, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        TextButton(
            onPressed: onViewAll,
            child: KText(
              text: subtitle,
              fontSize: 18,
              color: AppColors.primaryColor,
            )),
      ],
    );
  }
}
