import 'package:photobackup/utils/file_indexes.dart';

class IconContainer extends StatelessWidget {
  final Color bgColor;
  final Color? iconColor;
  final String text;
  final String iconPath;
  final VoidCallback onTap;
  const IconContainer({super.key, required this.bgColor, required this.text, required this.iconPath, required this.onTap, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: const Offset(0,4),
                    color: AppColors.galleryIconColor.withValues(alpha: 0.2)
                  )
                ]
              ),
              child: showSvgIconWidget(
                iconPath: iconPath,
                width: 20,
                height: 20,
                color: iconColor ?? AppColors.primaryColor,
                onTap: onTap,
              ),
            ),
            Space.vertical(1.6),
            KText(text: text,fontSize: 16,fontWeight: FontWeight.w500,textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
