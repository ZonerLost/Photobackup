import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/widgets/drawer_widgets/drawer_dialogues.dart';

class PhotosPageWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onDelete;
  final Function(int) onSelected;
  final int index;
  const PhotosPageWidget({super.key, required this.imageUrl, required this.onDelete,required this.onSelected, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             /* Padding(
                padding: const EdgeInsets.only(left: 10),
                child: KText(text: "img345768809"),
              ),*/
              PopupMenuButton<int>(

                itemBuilder: (context) => [
                  PopupMenuItem(value: 1, child: Center(child: KText(text: "View",))),
                  PopupMenuItem(value: 2, child: Center(child: KText(text: "Download"))),
                  PopupMenuItem(value: 3, child: Center(child: KText(text: "Delete"))),
                  PopupMenuItem(value: 4, child: Center(child: KText(text: "Share"))),
                ],
                offset: const Offset(0, 40),
                color: AppColors.whiteColor,
                elevation: 2,
                onSelected: onSelected
              ),
            ],
          ),
          Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          4.height
        ],
      ),
    );
  }
}
