import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/set_password.dart';
import 'package:photobackup/widgets/auth_widgets/auth_prompt_text.dart';
import 'package:photobackup/widgets/auth_widgets/verification_text_field.dart';

import '../../controller/auth_controller.dart';

class VerificationPage extends StatelessWidget {
  String email;
   VerificationPage({super.key,required this.email});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();
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
                  controller: otpController,
                ),
                Space.vertical(5),
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : kTextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.verifyResetWithOTP(email,otpController.text.trim());
                      }
                    },
                    btnText: 'Verify',
                    textColor: Colors.white,
                    color: AppColors.primaryColor,
                  );
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
