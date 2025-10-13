import 'package:photobackup/utils/file_indexes.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onAppleLogin;
  const SocialLoginButtons({super.key, required this.onGoogleLogin, required this.onAppleLogin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        spacing: 14,
        children: [
          Expanded(
              child: GestureDetector(
                onTap: onGoogleLogin,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightGreyColor, width: 1),
                  ),
                  child: showSvgIconWidget(
                    iconPath: AppIcons.googleIcon,
                  ),
                ),
              )),
          Expanded(
              child: GestureDetector(
                onTap: onAppleLogin,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.lightGreyColor, width: 1),
                  ),
                  child: Icon(Icons.apple),
                ),
              ))
        ],
      ),
    );
  }
}
