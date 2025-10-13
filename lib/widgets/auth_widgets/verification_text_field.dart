import 'package:photobackup/utils/file_indexes.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VerificationTextField extends StatelessWidget {
  final TextEditingController? controller;
  const VerificationTextField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: controller,
      separatorBuilder: (index) => SizedBox(width: 1.w),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      defaultPinTheme: PinTheme(
        padding: const EdgeInsets.all(20),
        textStyle: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.greyColor.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGreyColor,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      focusedPinTheme: PinTheme(
        padding: const EdgeInsets.all(20),
        textStyle: const TextStyle(fontSize: 20, color: Colors.black),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGreyColor,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
        validator: (pin) {
          // if (pin != null && pin.trim().length == 4) {
            return null;
          // } else {
          //   return 'Please enter a valid 4-digit code';
          // }
        }
    );
  }
}
