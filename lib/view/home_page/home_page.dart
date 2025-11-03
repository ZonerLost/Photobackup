import 'package:photobackup/controller/home_page_controller.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/home_page/all_album_page.dart';
import 'package:photobackup/view/home_page/all_photos_page.dart';
import 'package:photobackup/view/home_page/birthdays_page.dart';
import 'package:photobackup/view/home_page/choose_album.dart';
import 'package:photobackup/view/home_page/upload_photo_page.dart';
import 'package:photobackup/view/drawer/home_drawer.dart';
import 'package:photobackup/widgets/home_widgets/Icon_action_tile.dart';
import 'package:photobackup/widgets/home_widgets/custom_row.dart';
import 'package:photobackup/widgets/home_widgets/folder_widget.dart';
import 'package:photobackup/widgets/home_widgets/home_appbar.dart';

import '../../controller/all_photos_controller.dart';
import '../../controller/choose_album_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    ChooseAlbumController chooseAlbumController = Get.put(ChooseAlbumController());
    final imageUploadController = Get.put(ImageUploadController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HomeAppbar(),
      ),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            30.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconContainer(
                  bgColor: AppColors.lavenderBlue,
                  text: "Upload Photo",
                  iconPath: AppIcons.sendIcon,
                  iconColor: AppColors.primaryColor,
                  onTap: () => Get.to(() => UploadPhotoPage()),
                ),
                IconContainer(
                  bgColor: AppColors.lightSkyBlue,
                  text: "View all Photo",
                  iconPath: AppIcons.galleryIcon,
                  iconColor: AppColors.galleryIconColor,
                  onTap: () => Get.to(() => AllPhotosPage()),
                ),
                IconContainer(
                  bgColor: AppColors.pastelPink,
                  text: "Create Album",
                  iconPath: AppIcons.folderAddIcon,
                  iconColor: AppColors.folderIconColor,
                  onTap: () => Get.to(() => ChooseAlbum()),
                ),
              ],
            ),
            30.height,
            Obx(() {
              final images = imageUploadController.images;

              if (images.isEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRow(
                    title: "Recent Uploads",
                    subtitle: "View All",
                    onViewAll: () => Get.to(() => AllPhotosPage()),
                  ),
                  10.height,
                  SizedBox(
                    height: 106,
                    child: ListView.separated(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final image = images[index];

                        return GestureDetector(
                          onTap: () {
                            // Handle tap (open fullscreen, etc.)
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image.imageUrl,
                              width: 106,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                    ),
                  ),
                ],
              );
            }),
            20.height,
            Obx(() {
              final albums = chooseAlbumController.albums;

              if (albums.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomRow(
                    title: "Your Albums",
                    subtitle: "More Albums",
                    onViewAll: () => Get.to(() => AllAlbumPage()),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 160,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      final album = albums[index];
                      final imageCount = chooseAlbumController.getImageCountForAlbum(album.id);

                      return FolderWidget(
                        folderColor: controller.folderMainColors[index],
                        bdFolderColor: controller.folderAccentColors[index],
                        folderName: album.name,
                        subtitle: imageCount.toString(),
                        onTap: () {
                          Get.to(() => BirthdaysPage(
                            albumId: album.id,
                            name: album.name,
                          ));
                        },
                      );
                    },
                  ),
                  20.height
                ],
              );
            }),


          ],
        ),
      ),
    );
  }
}
