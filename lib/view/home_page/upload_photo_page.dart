import 'package:dotted_border/dotted_border.dart';
import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/widgets/auth_widgets/auth_prompt_text.dart';
import 'package:photobackup/widgets/home_widgets/dialog_box.dart';
import 'package:photobackup/widgets/home_widgets/uploading_content.dart';

import '../../controller/all_photos_controller.dart';
import '../../controller/home_page_controller.dart';

class UploadPhotoPage extends StatelessWidget {
   UploadPhotoPage({super.key});

  final imageUploadController = Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Upload Your Photos",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            16.height,
            KText(
              text: "Select images from your device to store them securely in the cloud",
              textAlign: TextAlign.center,
              color: AppColors.secondaryColor,
              fontSize: 16,
            ),
            30.height,
            GestureDetector(
              onTap: (){
                AppDialogBox.imageUploadedDialogue(
                    context: context,
                    onConfirm: () => Get.back(),
                    iconPath: AppIcons.imageUploadedIcon,
                    title: 'Image Uploaded',
                    content: 'Your image has been successfully uploaded!',
                    confirmText: 'Add to Album',
                    textColor: AppColors.whiteColor,
                    cancelText: 'Skip for now',
                    borderColor: AppColors.primaryColor,
                    btnColor: AppColors.primaryColor
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(text: "Upload Images",fontWeight: FontWeight.w500,),
                  6.height,
                  DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        dashPattern: [6, 6],
                        strokeWidth: 1,
                        color: AppColors.primaryColor,
                        radius: Radius.circular(12),
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.uploadPhoto,
                            width: 160,
                            height: 100,
                          ),
                          20.height,
                          KRichText(
                            normalText: "Drop your files here or ",
                            actionText: "Click to upload",
                            textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                            onActionTap: () {
                              imageUploadController.pickAndCompressImages(context);
                             /* AppDialogBox.imageUploadedDialogue(
                                context: context,
                                onConfirm: () => Get.back(),
                                iconPath: AppIcons.invalidFileIcon,
                                title: 'Invalid File',
                                content: ' Invalid file, upload another Photo',
                                confirmText: 'Re-upload',
                                textColor: Colors.red,
                                cancelText: 'Cancel',
                                borderColor: Colors.red,
                              );*/
                            },
                          ),
                          6.height,
                          KText(text: 'SVG, PNG or JPG (max. 800x400px)',color: AppColors.secondaryColor,)
                        ],
                      )
                  ),
                  38.height,
                  UploadingContent(percentage: "45", remainingTime: "• 50sec remaining", onClose: (){
                    AppDialogBox.imageUploadedDialogue(
                      context: context,
                      onConfirm: () => Get.back(),
                      iconPath: AppIcons.failedIcon,
                      title: 'Oh Snap!',
                      content: 'Upload failed Try again.',
                      confirmText: 'Try Again',
                      textColor: Colors.red,
                      cancelText: 'Cancel',
                      borderColor: Colors.red,
                    );
                  },),
                  18.height,
                  UploadingContent(percentage: "25", remainingTime: "• 1m remaining", onClose: (){
                    AppDialogBox.imageUploadedDialogue(
                      context: context,
                      onConfirm: () => Get.back(),
                      iconPath: AppIcons.connectionErrorIcon,
                      title: 'Connection Error',
                      content: 'No Internet, Check your connection',
                      confirmText: 'Try Again',
                      textColor: AppColors.primaryColor,
                      cancelText: 'Cancel',
                      borderColor: AppColors.primaryColor,
                    );
                  },)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

