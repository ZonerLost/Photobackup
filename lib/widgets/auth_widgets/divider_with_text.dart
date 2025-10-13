import 'package:photobackup/utils/file_indexes.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: AppColors.lightGreyColor, thickness: 1)),
          KText(
            text: text,
            color: AppColors.greyText,
          ),
          Expanded(child: Divider(color: AppColors.lightGreyColor, thickness: 1)),
        ],
      ),
    );
  }
}
