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
            CustomRow(title: "Recent Uploads", subtitle: "View All",onViewAll: () => Get.to(() => AllPhotosPage()),),
            10.height,
            SizedBox(
              height: 106,
              child: Obx(() {
                if (imageUploadController.images.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                  itemCount: imageUploadController.images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final images = imageUploadController.images[index];

                    return GestureDetector(
                      onTap: () {
                        // Handle tap (open fullscreen, etc.)
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          images.imageUrl,
                          width: 106,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                );
              }),
            ),

            20.height,
            CustomRow(title: "Your Albums", subtitle: "More Albums",onViewAll: () => Get.to(() => AllAlbumPage()),),
            Obx((){
              if (chooseAlbumController.albums.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 190,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                itemCount: chooseAlbumController.albums.length,
                itemBuilder: (context, index) {
                  final album = chooseAlbumController.albums[index];
                  final imageCount = chooseAlbumController.getImageCountForAlbum(album.id);

                  return FolderWidget(
                    folderColor: controller.folderMainColors[index],
                    bdFolderColor: controller.folderAccentColors[index],
                    folderName: chooseAlbumController.albums[index].name,
                    subtitle: imageCount.toString(),
                    onTap: () {
                      Get.to(() => BirthdaysPage(
                        albumId: chooseAlbumController.albums[index].id,
                        name: chooseAlbumController.albums[index].name,
                      ));
                    },
                  );
                },
              );
              },),
            20.height
          ],
        ),
      ),
    );
  }
}
