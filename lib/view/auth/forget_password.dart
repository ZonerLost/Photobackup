import 'package:photobackup/components/custom_appbar.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/verification_page.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';

import '../../controller/auth_controller.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({super.key});
   final formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Reset Your Password",
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
              KText(
                text: "We’ll help you get back into your account",
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
              50.height,
              Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : kTextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.forgotPassword(emailController.text.trim());
                    }
                  },
                  btnText: 'Send Code',
                  textColor: Colors.white,
                  color: AppColors.primaryColor,
                );
              }),
            ],
          ),
        ),
      )
    );
  }
}
