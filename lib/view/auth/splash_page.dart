import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:photobackup/view/auth/login_page.dart';
import 'package:photobackup/view/auth/welcome_page.dart';
import 'package:photobackup/view/home_page/home_page.dart';
import '../../controller/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    // Wait 3 seconds for splash
    await Future.delayed(const Duration(seconds: 3));

    // Ensure the SharedPreferences value is loaded
    await authController.loadWelcomeStatus();
    await authController.loadRememberedStatus();

    if (!authController.isWelcomeShown.value) {
      Get.offAll(() => const WelcomePage());
    } else {
      if (authController.isRemembered.value) {
        Get.offAll(() => HomePage());
      } else {
        Get.offAll(() => LoginPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: const Center(
        child: KText(
          text: 'Logo',
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
