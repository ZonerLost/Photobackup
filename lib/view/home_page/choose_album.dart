import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/home_page/new_album_page.dart';
import 'package:photobackup/widgets/home_widgets/dialog_box.dart';

import '../../controller/all_photos_controller.dart';
import '../../controller/choose_album_controller.dart';
import 'home_page.dart';

class ChooseAlbum extends StatelessWidget {
  final ChooseAlbumController controller = Get.put(ChooseAlbumController());
  final ImageUploadController imageUploadController =
      Get.put(ImageUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Choose Album"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.height,
              KText(
                text: "Select album to add the photo",
                textAlign: TextAlign.center,
                color: AppColors.greyText,
                fontSize: 16,
              ),
              40.height,

              /// List of albums from Supabase
              Center(
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      controller.albums.length,
                      (index) => SizedBox(
                        width: 250,
                        child: RadioListTile(
                          activeColor: AppColors.primaryColor,
                          value: index,
                          groupValue: controller.selectedAlbumIndex.value,
                          onChanged: (val) {
                            controller.selectedAlbumIndex.value = val as int;
                          },
                          title: KText(
                            text: controller.albums[index].name,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Obx(() =>
                  controller.albums.isNotEmpty ? 60.height : SizedBox.shrink()),

              /// Select Button
              Obx(() => controller.albums.isNotEmpty
                  ? kTextButton(
                      btnText: "Select Album",
                      color: AppColors.primaryColor,
                      onPressed: () {
                        if (controller.selectedAlbumIndex.value != -1) {
                          final selectedAlbum = controller
                              .albums[controller.selectedAlbumIndex.value];
                          imageUploadController
                              .uploadSelectedImages(albumId: selectedAlbum.id)
                              .then((_) {
                            Get.offAll(() => HomePage());
                          });
                        }
                      },
                    )
                  : SizedBox.shrink()),

              18.height,

              /// Create New Album
              kTextButton(
                btnText: "Create New",
                textColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                onPressed: () => AppDialogBox.createAlbum(
                  context,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
