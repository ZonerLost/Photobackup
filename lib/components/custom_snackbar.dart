import 'package:photobackup/utils/file_indexes.dart';

void showSnackBar(String title, String message,{bool isError = false}) {
  Get.showSnackbar(
    GetSnackBar(
      borderRadius: 14,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),

      titleText: KText(text: title,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 15,
      ),
      messageText: KText(text: message, color: Colors.white, fontSize: 13,),
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: isError ? Colors.red : AppColors.primaryColor,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      icon: isError
          ? const Icon(Icons.error,color: Colors.white,)
          : const Icon(Icons.check_circle,color: Colors.green,),
      margin: const EdgeInsets.all(10),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
    ),
  );
}


void showConsole(String message) {
  if(kDebugMode){
    print(message);
  }

}




class CustomSnackBars {
  CustomSnackBars._();
  static final CustomSnackBars instance = CustomSnackBars._();

  void showSuccessSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  void showFailureSnackbar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}
