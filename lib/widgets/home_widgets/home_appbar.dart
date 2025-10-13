import 'package:photobackup/utils/file_indexes.dart';

import '../../controller/home_page_controller.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return Obx((){
      final user = controller.user.value;
      return AppBar(
        actionsPadding: const EdgeInsets.only(right: 20),
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.whiteColor,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(left: 20),
            child: showSvgIconWidget(
              iconPath: AppIcons.menuIcon,
              width: 20,
              height: 20,
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            KText(
              text: user != null ? "Hi ${user.name}," : "Hi,Ria",
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
            6.height,
            KText(
              text: "What would you like to do today?",
              fontSize: 14,
              color: AppColors.greyText,
            ),
            6.height,
          ],
        ),
        actions: [
          if (user != null && user.profilePic.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                user.profilePic,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          else
            Image.asset(
              AppImages.profile, // fallback image
              width: 40,
              height: 40,
            ),
        ],
      );
    });
  }
}
