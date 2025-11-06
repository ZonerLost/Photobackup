import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/drawer/change_password.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';

import '../../controller/auth_controller.dart';
import '../../controller/home_page_controller.dart';

class ProfileSetting extends StatelessWidget {
  ProfileSetting({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());
  final homeController = Get.find<HomePageController>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 👇 Fetch user profile when screen opens
    controller.getCurrentUserProfile();
  //  final user = homeController.user.value;

    return Scaffold(
      appBar: CustomAppBar(title: "Profile Setting"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Space.vertical(4),
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      final user = homeController.user.value;
                      if (user != null && emailController.text.isEmpty) {
                        emailController.text = user.email;
                      }
                      return CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage: user != null && user.profilePic.isNotEmpty
                            ? NetworkImage(user.profilePic)
                            : AssetImage(AppImages.profile) as ImageProvider,
                      );
                    }),

                   /* Positioned(
                      bottom: 0,
                      right: 12,
                      child: GestureDetector(
                        //onTap: () => controller.pickImage(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.skyMist,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: showSvgIconWidget(iconPath: AppIcons.galleryEditIcon),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
              8.height,
              CustomTextField(
                title: "Email",
                controller: emailController, // 👈 use controller here
                hintText: "Enter your email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  }
                  if (!GetUtils.isEmail(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              20.height,
              CustomTextField(
                obscureText: true,
                title: "Password",
                hintText: "Enter your password",
                showSuffixIcon: true,
                suffixIcon: TextButton(
                  //onPressed: () => Get.to(() => const ChangePassword()),
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                      controller.isLogin.value = true;
                      controller.forgotPassword(emailController.text.trim());
                    }
                  },
                  child: KText(
                    text: "Change Password",
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

