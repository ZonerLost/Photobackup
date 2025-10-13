import 'package:photobackup/utils/file_indexes.dart';

class DrawerDialogues{
  static Future<void> confirmationDialog({
    required BuildContext context,
    required String iconPath,
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    Color? cancelBtnColor,
    Color? borderColor,
    bool? showBorderColor,
    required Color textColor,
    Color? btnColor,
    required VoidCallback onConfirm,
  }) {
    return showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
        ),
        backgroundColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showSvgIconWidget(iconPath: iconPath,),
            KText(text: title, fontSize: 22,fontWeight: FontWeight.w600 ,),
            Space.vertical(2),
            KText(text: content, fontSize: 15,color: AppColors.greyText,textAlign: TextAlign.center,),
            Space.vertical(4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: kTextButton(
                        onPressed: () => Get.back(),
                        btnText: cancelText,
                        color: cancelBtnColor,
                        borderColor: showBorderColor == true ? AppColors.secondaryColor : null,
                        textColor: cancelBtnColor != null ? AppColors.whiteColor :AppColors.greyText
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: kTextButton(
                        onPressed: onConfirm,
                        borderColor: borderColor,
                        textColor: textColor,
                        color: btnColor,
                        btnText: confirmText,
                        borderRadius: 10
                    ),
                  ),
                ],
              ),
            ),
            Space.vertical(6)
          ],
        ),
      ),
    );
  }
}