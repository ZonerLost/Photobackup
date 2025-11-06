import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/components/k_text_fields.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/home_page/image_view_page.dart';
import 'package:photobackup/widgets/drawer_widgets/drawer_dialogues.dart';
import 'package:photobackup/widgets/home_widgets/photos_page_widget.dart';

import '../../controller/all_photos_controller.dart';
import '../../controller/choose_album_controller.dart';
import '../../services/download_service.dart';

class BirthdaysPage extends StatelessWidget {
  String albumId;
  String name;
  BirthdaysPage({super.key, required this.albumId, required this.name,});
  final imageUploadController = Get.put(ImageUploadController());
  final albumController = Get.put(ChooseAlbumController());

  @override
  Widget build(BuildContext context) {
    albumController.fetchAlbumImages(albumId);

    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CustomAppBar(
        title: name,
        backgroundColor: AppColors.backGroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
           /* GetTextField(
              prefixIcon: AppIcons.searchIcon,
              context: context,
              hintText: "Search by title",
              borderColor: AppColors.lightGreyColor,
            ),
            Space.vertical(3),*/

            Space.vertical(2),
            /// ✅ Listen to albumController images
            Expanded(
              child: Obx(() {
                if (albumController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (albumController.selectedAlbumImages.isEmpty) {
                  return const Center(child: Text("No images found"));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: albumController.selectedAlbumImages.length,
                  itemBuilder: (context, index) {
                    final img = albumController.selectedAlbumImages[index];
                    return PhotosPageWidget(
                      index: index,
                      imageUrl: img.imageUrl, // ✅ use Supabase URL
                      onSelected: (value) {
                        if (value == 1) {
                          Get.to(() => ImageViewPage(
                                images: img.imageUrl,
                                selectedImage: index,
                              ));
                        }
                        if (value == 2) {
                          ///Download image
                          DownloadService.instance.downloadImage(img.imageUrl).then((_) {
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
                            btnColor: AppColors.primaryColor,
                            showBorderColor: false,
                            cancelBtnColor: AppColors.lightGreyColor,
                            onConfirm: () {
                              imageUploadController.deleteImage(img.id,img .imageUrl);
                              Get.back();
                            },
                          );
                        }
                        if (value == 4) {
                          imageUploadController.shareImage(
                            img.imageUrl,
                            imageName: 'my_photo.jpg',
                          );

                        }
                      },
                      onDelete: () {
                        // TODO: Delete logic
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
