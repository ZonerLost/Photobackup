import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/login_page.dart';

class AuthDialogues{
  static successDialog(BuildContext context,{VoidCallback? onPressed}){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.whiteColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset(AppImages.passwordUpdated)),
              ),
            ),
            5.height,
            KText(
              text: "Password Updated Successfully",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            10.height,
            KText(
              text: "You can now log in with your new password",
              fontSize: 14,
              color: AppColors.greyText,
            ),
          ],
        ),
        actions: [
          kTextButton(
            btnText: "Login",
            color: AppColors.primaryColor,
            onPressed: onPressed ?? () {
              Get.offAll(() => LoginPage());
            },
          )
        ],
      );
    });
  }
}