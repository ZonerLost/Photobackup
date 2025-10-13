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
    return Scaffold(
      appBar: CustomAppBar(
        title: "All Albums",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GetTextField(
              prefixIcon: AppIcons.searchIcon,
              context: context,
              hintText: "Search by title",
              borderColor: AppColors.lightGreyColor,
            ),
            Space.vertical(3),
           Obx((){
             if (chooseAlbumController.albums.isEmpty) {
               return const Center(child: CircularProgressIndicator());
             }
             return  Expanded(
               child: GridView.builder(
                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                     maxCrossAxisExtent: 300,
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10
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
               ),
             );
           },
           ),
          ],
        ),
      ),
    );
  }
}
