import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/forget_password.dart';
import 'package:photobackup/view/auth/signup_page.dart';
import 'package:photobackup/view/home_page/home_page.dart';
import 'package:photobackup/widgets/auth_widgets/auth_prompt_text.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';
import 'package:photobackup/widgets/auth_widgets/divider_with_text.dart';
import 'package:photobackup/widgets/auth_widgets/k_check_box.dart';
import 'package:photobackup/widgets/auth_widgets/social_login_buttons.dart';

import '../../controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.put(AuthController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
                text: "Let’s Sign you in.",
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              KText(
                text: "Access your account securely and continue where you left off",
                fontSize: 14,
                color: AppColors.greyText,
              ),
              28.height,
              CustomTextField(
                controller: emailController,
                title: "Email",
                hintText: "Enter Email",
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
              22.height,
              CustomTextField(
                controller: passwordController,
                obscureText: true,
                title: "Password",
                hintText: "Enter Password",
                textInputAction: TextInputAction.done,
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
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => KCheckBox(
                        value: controller.isRemembered.value,
                        onChanged: (val) {
                          controller.setRemembered(val ?? false);
                        },
                      )),
                      KText(text: "Remember Me?", fontSize: 14, color: AppColors.primaryColor),
                    ],
                  ),
                  GestureDetector(
                      onTap: () => Get.to(() =>  ForgetPassword()),
                      child: KText(text: "Forgot password?", fontSize: 14, color: AppColors.primaryColor)),
                ],
              ),
              40.height,
              Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : kTextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.loginUser(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    }
                  },
                  btnText: 'Login',
                  textColor: Colors.white,
                  color: AppColors.primaryColor,
                );
              }),
              34.height,
              DividerWithText(text: "Or Sign up with"),
              20.height,
              SocialLoginButtons(
                onGoogleLogin: () {
                  controller.loginWithGoogle();
                },
                onAppleLogin: () {},
              ),
              20.height,
              KRichText(
                normalText: "Don't have an account? ",
                actionText: "Sign up",
                onActionTap: () => Get.to(() => SignupPage()),
              ),
              20.height
            ],
          ),
        ),
      ),
    );
  }
}

