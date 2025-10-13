import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:photobackup/utils/file_indexes.dart';


class AppDialogs {

  static showLoading() {
    return Get.dialog(
      barrierDismissible: false,
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child : PopScope(
          canPop: false,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:  Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: CustomLoading(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static stopProcess() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final double indicatorSize = MediaQuery.of(context).size.width * 0.08;
    return  Center(
      child: SizedBox(
        width: indicatorSize,
        height: indicatorSize,
        child: Platform.isIOS
            ? CupertinoActivityIndicator(
          color: AppColors.primaryColor,
          radius: indicatorSize / 2, // Adjust the radius to match size
        )
            : CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          color: AppColors.primaryColor,
          strokeWidth: indicatorSize * 0.1, // Adjust stroke width
        ),
      ),
    );
  }
}

Widget buildPostLoading() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 7),
    decoration: BoxDecoration(
      color: AppColors.greyColor.withValues(alpha:  0.2),
      borderRadius: BorderRadius.circular(14),
    ),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomLoading(),
        Space.horizontal(1),
        KText(
          text: 'Loading...',
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}