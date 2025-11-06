import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/components/k_text_fields.dart';
import 'package:photobackup/controller/all_album_controller.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/home_page/birthdays_page.dart';
import 'package:photobackup/widgets/home_widgets/folder_widget.dart';

import '../../controller/choose_album_controller.dart';

class AllAlbumPage extends StatelessWidget {
  const AllAlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    AllAlbumController controller = Get.put(AllAlbumController());
    ChooseAlbumController chooseAlbumController = Get.put(ChooseAlbumController());

    // 👇 Add an observable for search query
    final RxString searchQuery = ''.obs;

    return Scaffold(
      appBar: CustomAppBar(
        title: "All Albums",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // 🔍 Search TextField
            GetTextField(
              prefixIcon: AppIcons.searchIcon,
              context: context,
              hintText: "Search by title",
              borderColor: AppColors.lightGreyColor,
              onChanged: (value) => searchQuery.value = value.trim().toLowerCase(),
            ),
            Space.vertical(3),

            // 🧩 Display albums based on search
            Obx(() {
              if (chooseAlbumController.albums.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              // 🔹 Filter albums by search query
              final filteredAlbums = chooseAlbumController.albums.where((album) {
                return album.name.toLowerCase().contains(searchQuery.value);
              }).toList();

              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: filteredAlbums.length,
                  itemBuilder: (context, index) {
                    final album = filteredAlbums[index];
                    final imageCount = chooseAlbumController.getImageCountForAlbum(album.id);

                    return FolderWidget(
                      folderColor: controller.folderMainColors[index % controller.folderMainColors.length],
                      bdFolderColor: controller.folderAccentColors[index % controller.folderAccentColors.length],
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
