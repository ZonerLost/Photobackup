
import 'package:photobackup/utils/file_indexes.dart';

Widget showSvgIconWidget({required String iconPath, bool replacement = false,
  Widget? page, Function()? onTap,Color? color,double? width,double? height}) {
  return GestureDetector(
      onTap: () {
        if(onTap != null){
          onTap();
        }
        if (page != null){
          if(replacement){
            Get.offAll(() => page);
          }else{
            Get.to(() => page);
          }
        }
      },
      child: SvgPicture.asset(
        iconPath,
        colorFilter:  color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
        width: width,
        height: height,
      ));
}