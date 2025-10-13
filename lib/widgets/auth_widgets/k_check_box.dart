import 'package:flutter/material.dart';
import 'package:photobackup/constants/app_colors.dart';

class KCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  const KCheckBox({super.key, required this.value,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: const BorderSide(color: AppColors.primaryColor, width: 2,),
        activeColor: AppColors.primaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact);
  }
}
