import 'package:photobackup/utils/file_indexes.dart';

class UploadingContent extends StatelessWidget {
  final String percentage;
  final String remainingTime;
  final VoidCallback onClose;
  const UploadingContent({super.key, required this.percentage, required this.remainingTime, required this.onClose,});

  @override
  Widget build(BuildContext context) {
    double proVal = int.parse(percentage) / 100;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.lightGreyColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyText.withValues(alpha: 0.3),
              blurRadius: 24,
              offset: const Offset(0, 4),
            )
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: "Uploading",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              GestureDetector(
                onTap: onClose,
                child: Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.whiteColor,
                      border: Border.all(color: AppColors.primaryColor, width: 1),
                    ),
                    child: Icon(
                      Icons.close,
                      color: AppColors.primaryColor,
                      size: 10,
                    )),
              ),
            ],
          ),
          4.height,
          Row(
            children: [
              KText(
                text: "$percentage%  ",
                color: AppColors.greyText,
              ),
              KText(
                text: remainingTime,
                color: AppColors.greyText,
              ),
            ],
          ),
          12.height,
          LinearProgressIndicator(
            minHeight: 8,
            value: proVal,
            backgroundColor: AppColors.lightGreyColor,
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          6.height
        ],
      ),
    );
  }
}
