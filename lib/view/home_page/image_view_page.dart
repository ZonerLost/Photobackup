import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';

class ImageViewPage extends StatefulWidget {
  final String images;
  final int selectedImage;

  const ImageViewPage({
    super.key,
    required this.images,
    required this.selectedImage,
  });

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  RxInt currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    currentIndex.value = widget.selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        icon: showSvgIconWidget(iconPath: AppIcons.exportIcon),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Space.vertical(3),
            SizedBox(
              width: size.width,
              height: size.height / 2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.images,
                      width: size.width,
                      height: size.height / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Left Arrow
                  /*Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => swipeImages(false),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  // Right Arrow
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => swipeImages(true),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void swipeImages(bool isNext) {
    if (isNext) {
      if (currentIndex.value == widget.images.length - 1) {
        currentIndex.value = 0;
      } else {
        currentIndex.value++;
      }
    } else {
      if (currentIndex.value == 0) {
        currentIndex.value = widget.images.length - 1;
      } else {
        currentIndex.value--;
      }
    }
  }

}
