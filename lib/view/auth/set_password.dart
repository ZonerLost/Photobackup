import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/login_page.dart';
import 'package:photobackup/widgets/auth_widgets/auth_dialogues.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';

import '../../controller/auth_controller.dart';

class SetPassword extends StatelessWidget {
   SetPassword({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Set a New Password",
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              KText(
                text: "Create a strong password to secure your account",
                fontSize: 14,
                color: AppColors.greyText,
              ),
              28.height,
              CustomTextField(
                obscureText: true,
                title: "Password",
                hintText: "Enter Password",
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              22.height,
              CustomTextField(
                obscureText: true,
                title: "Confirm Password",
                hintText: "Rewrite Password",
                textInputAction: TextInputAction.done,
                controller: newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password";
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              40.height,
              Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : kTextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.updatePassword(context: context, newPassword: newPasswordController.text.trim(),currentPassword: "bcs123456789",isResetFlow: true);
                    }
                  },
                  btnText: 'Change Password',
                  textColor: Colors.white,
                  color: AppColors.primaryColor,
                );
              }),
              34.height,
            ],
          ),
        ),
      ),
    );
  }
}
