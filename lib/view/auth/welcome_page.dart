import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/login_page.dart';
import 'package:photobackup/view/auth/signup_page.dart';
import '../../controller/auth_controller.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Space.vertical(4),
              Image(image: AssetImage(AppImages.welcome)),
              Space.vertical(4),
              Column(
                children: [
                  KText(
                    text: 'Welcome to Photo Backup',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  10.height,
                  KText(
                    textAlign: TextAlign.center,
                    text: 'Lorem Ipsumkjsdsbnckjsjdh biufswhhhfui ihefsdkjbknf iuwebfkjwerw iufbw ugiwerf werjiufhwe fuiwef hiwerifwrhiy',
                    fontSize: 16,
                    color: AppColors.greyText,
                  ),
                ],
              ),
              Space.vertical(6),
              Column(
                spacing: 20,
                children: [
                  kTextButton(onPressed: () => Get.to(() => LoginPage()), btnText: 'Login', color: AppColors.primaryColor),
                  kTextButton(
                      onPressed: () => Get.to(() => SignupPage()),
                      btnText: 'Signup',
                      textColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor),
                ],
              ),
              Space.vertical(6),
            ],
          ).paddingSymmetric(horizontal: 22),
        ));
  }
}
