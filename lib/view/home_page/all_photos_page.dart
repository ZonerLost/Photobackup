import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/controller/all_photos_controller.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/home_page/image_view_page.dart';
import 'package:photobackup/widgets/drawer_widgets/drawer_dialogues.dart';
import 'package:photobackup/widgets/home_widgets/photos_page_widget.dart';

import '../../services/download_service.dart';

class AllPhotosPage extends StatelessWidget {
  const AllPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUploadController = Get.put(ImageUploadController());

    // Fetch images once when controller is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imageUploadController.fetchUserImages();
    });

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CustomAppBar(
        title: "All Photos",
        backgroundColor: AppColors.backGroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            30.height,
            Expanded(
              child: Obx(() {
                if (imageUploadController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (imageUploadController.images.isEmpty) {
                  return const Center(child: Text("No images found"));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: imageUploadController.images.length,
                  itemBuilder: (context, index) {
                    final image = imageUploadController.images[index];

                    print("Images length :::: ${imageUploadController.images.length}");
                    return PhotosPageWidget(
                      index: index,
                      imageUrl: image.imageUrl, // ✅ assuming ImageModel has url
                      onSelected: (value) {
                        if (value == 1) {
                          Get.to(() => ImageViewPage(
                            images: image.imageUrl,
                            selectedImage: index,
                          ));
                        }
                        if (value == 2) {
                          ///Download image
                          DownloadService.instance.downloadImage(image.imageUrl).then((_) {
                            Get.snackbar("Download", "Image saved successfully");
                          }).catchError((e) {
                            Get.snackbar("Error", "Download failed: $e");
                          });
                        }
                        if (value == 3) {
                          DrawerDialogues.confirmationDialog(
                            context: context,
                            iconPath: AppIcons.deletePhoto,
                            title: "Delete Image",
                            content:
                            "Are you sure you want to delete this image?",
                            confirmText: "Yes",
                            cancelText: "Cancel",
                            textColor: AppColors.whiteColor,
                            btnColor: AppColors.redColor,
                            showBorderColor: false,
                            cancelBtnColor: AppColors.lightGreyColor,
                            onConfirm: () {
                              imageUploadController.deleteImage(image.id,image.imageUrl);
                              Get.back();
                            },
                          );
                        }
                      },
                      onDelete: () {
                        /*imageUploadController.deleteImage(image.id,image.imageUrl).then((_){
                          Get. back();
                        });*/
                      },
                    );
                  },
                );
              }),
            ),
            Space.vertical(2),
          ],
        ),
      ),
    );
  }
}
