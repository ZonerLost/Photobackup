import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/widgets/auth_widgets/custom_textfield.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              fontSize: 16,
              color: AppColors.greyText,
            ),
            28.height,
            CustomTextField(obscureText: true, title: "Old Password", hintText: "Enter Old Password"),
            22.height,
            CustomTextField(
              obscureText: true,
              title: "New Password",
              hintText: "Enter New Password",
            ),
            22.height,
            CustomTextField(
              obscureText: true,
              title: "Confirm New Password",
              hintText: "Rewrite New Password",
              textInputAction: TextInputAction.done,
            ),
            40.height,
            kTextButton(
              onPressed: () {},
              btnText: 'Reset',
              textColor: Colors.white,
              color: AppColors.primaryColor,
            ),
            20.height
          ],
        ),
      ),
    );
  }
}
