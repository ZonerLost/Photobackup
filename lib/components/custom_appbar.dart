import 'package:photobackup/utils/file_indexes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;

  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      backgroundColor: backgroundColor ?? Colors.white,
      title: title != null
          ? KText(
              text: title!,
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: textColor,
            )
          : null,
      centerTitle: true,
      actions: icon != null ? [
        Padding(
        padding: const EdgeInsets.only(right: 20),
        child: icon!,
      )
      ] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
