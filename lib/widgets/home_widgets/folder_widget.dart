import 'package:flutter/material.dart';
import 'package:photobackup/utils/file_indexes.dart';

class FolderWidget extends StatelessWidget {
  final String folderName;
  final String subtitle; // Optional subtitle
  final VoidCallback? onTap;
  final Color folderColor;
  final Color bdFolderColor;

  const FolderWidget({
    super.key,
    required this.folderName,
    required this.subtitle,
    this.onTap,
    required this.folderColor,
    required this.bdFolderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 150,
            height: 115,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 20,
                  right: 0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: folderColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipPath(
                    clipper: FolderFrontClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bdFolderColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Space.vertical(0.6),
          KText(text: folderName,fontSize: 16,fontWeight: FontWeight.w500,),
          KText(text: subtitle,fontSize: 11,fontWeight: FontWeight.w500,color: AppColors.greyText,)
        ],
      ),
    );
  }
}


class FolderFrontClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 10;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.3, size.height * 0.15);

    path.lineTo(size.width - radius, size.height * 0.15);
    path.quadraticBezierTo(size.width, size.height * 0.15, size.width, size.height * 0.15 + radius);


    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);

    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}