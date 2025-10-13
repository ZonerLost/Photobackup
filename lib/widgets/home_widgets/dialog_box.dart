import 'package:photobackup/components/k_text_fields.dart';
import 'package:photobackup/utils/file_indexes.dart';

import '../../controller/choose_album_controller.dart';

class AppDialogBox{
  static Future<void> imageUploadedDialogue({
    required BuildContext context,
    required String iconPath,
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    Color? borderColor,
    required Color textColor,
    Color? btnColor,
    required VoidCallback onConfirm,
  }) {
    return showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog.adaptive(
        backgroundColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showSvgIconWidget(iconPath: iconPath,),
            KText(text: title, fontSize: 22,fontWeight: FontWeight.w600 ,),
            Space.vertical(1),
            KText(text: content, fontSize: 15,color: AppColors.greyText,textAlign: TextAlign.center,),
            Space.vertical(3.5),
            kTextButton(
                onPressed: onConfirm,
                borderColor: borderColor,
                textColor: textColor,
                color: btnColor,
                btnText: confirmText,
                borderRadius: 10
            ),
            kTextButton(
              onPressed: () => Get.back(),
              btnText: cancelText,
              textColor: AppColors.greyText
            )
          ],
        ),
      ),
    );
  }



  static createAlbum(BuildContext context,){
    showDialog(context: context, builder: (context){
      final ChooseAlbumController chooseAlbumController = Get.put(ChooseAlbumController());
      return AlertDialog(
        backgroundColor: AppColors.whiteColor,
        title: KText(text: "New Album",fontSize: 18,fontWeight: FontWeight.w600,),
        content: GetTextField(
          controller: chooseAlbumController.albumNameController,
          context: context,
          hintText: "Untitled album",),
        actions: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: kTextButton(
                  btnText: "Cancel",
                  color: AppColors.lightGreyColor,
                  onPressed: () => Get.back(),
                ),
              ),
              Expanded(
                child: kTextButton(
                  btnText: "Create",
                  color: AppColors.primaryColor,
                  onPressed: (){
                    if( chooseAlbumController.albumNameController.text.isNotEmpty){
                      chooseAlbumController.createAlbum();
                    }
                  },
                ),
              ),
            ],
          )
        ],
      );
    });
  }

}