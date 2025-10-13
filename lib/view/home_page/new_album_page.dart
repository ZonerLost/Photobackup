import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';

class NewAlbumPage extends StatelessWidget {
  const NewAlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "New Album",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              Space.vertical(13),
              CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(AppImages.albumImage)),
              KText(text: "No photo uploaded yet",fontSize: 18,color: AppColors.greyText,fontWeight: FontWeight.w400,),
              Space.vertical(6),
              kTextButton(
                btnText: "Upload Photos",
                color: AppColors.primaryColor
              ),
              Space.vertical(4),
            ],
          ),
        ),
      ),
    );
  }
}
