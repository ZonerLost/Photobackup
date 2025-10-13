import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/login_page.dart';
import 'package:photobackup/widgets/auth_widgets/auth_prompt_text.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';
import 'package:photobackup/widgets/auth_widgets/divider_with_text.dart';
import 'package:photobackup/widgets/auth_widgets/social_login_buttons.dart';

import '../../controller/auth_controller.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final AuthController controller = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                text: "Create a New Account",
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              KText(
                text: "Join us and start your journey today",
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
                controller: confirmPasswordController,
                obscureText: true,
                title: "Confirm Password",
                hintText: "Rewrite Password",
                textInputAction: TextInputAction.done,
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
                            controller.signUpUser(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          }
                        },
                        btnText: 'Sign Up',
                        textColor: Colors.white,
                        color: AppColors.primaryColor,
                      );
              }),
              34.height,
              DividerWithText(text: "Or Log in with"),
              20.height,
              SocialLoginButtons(
                onGoogleLogin: () {
                  controller.loginWithGoogle();
                },
                onAppleLogin: () {},
              ),
              20.height,
              KRichText(
                normalText: "Already have an account? ",
                actionText: "Login",
                onActionTap: () => Get.to(() =>  LoginPage()),
              ),
              20.height
            ],
          ),
        ),
      ),
    );
  }
}
