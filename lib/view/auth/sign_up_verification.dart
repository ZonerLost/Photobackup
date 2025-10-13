import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photobackup/extensions/keyboard_extension.dart';

import '../../components/custom_appbar.dart';
import '../../components/k_buttons.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controller/auth_controller.dart';
import '../../utils/spacing.dart';
import '../../widgets/auth_widgets/auth_prompt_text.dart';
import '../../widgets/auth_widgets/verification_text_field.dart';



class SignUpVerification extends StatelessWidget {
  String email;
  SignUpVerification({
    super.key,
    required this.email, // require email
  });
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    //print("Verifying: $email");
    final controller = TextEditingController();
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
                  text: "Please check your email",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
                KText(
                  text: "A verification code has been sent to your email",
                  fontSize: 14,
                  color: AppColors.secondaryColor,
                ),
                Space.vertical(3),
                VerificationTextField(
                  controller: controller,
                ),
                Space.vertical(5),
                kTextButton(
                    btnText: "Verify",
                    color: AppColors.primaryColor,
                    onPressed: () async {
                      //Get.to(() => const SetPassword());
                      if (formKey.currentState!.validate()) {
                        await authController.verifyOTP(email, controller.text.trim());
                      }
                    }),
                16.height,
                KRichText(normalText: "Send code again  ", actionText: "00:20",textStyle: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),),
              ],
            ),
          ),
        ));
  }
}
