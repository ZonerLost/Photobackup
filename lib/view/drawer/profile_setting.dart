import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/drawer/change_password.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile Setting",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Space.vertical(4),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      AppImages.profile,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.skyMist, borderRadius: BorderRadius.circular(50)),
                        child: showSvgIconWidget(iconPath: AppIcons.galleryEditIcon),
                      )),
                ],
              ),
            ),
            8.height,
            CustomTextField(title: "Email", hintText: "Enter your email"),
            20.height,
            CustomTextField(
              obscureText: true,
              title: "Password",
              hintText: "Enter your password",
              showSuffixIcon: true,
              suffixIcon: TextButton(
                  onPressed: () => Get.to(() => const ChangePassword()),
                  child: KText(
                    text: "Change Password",
                    color: AppColors.primaryColor,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
