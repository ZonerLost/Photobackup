import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DownloadService {
  static final DownloadService instance = DownloadService._internal();
  DownloadService._internal();

  Future<void> downloadImage(String imageUrl) async {
    try {
      // 🔹 Detect Android version
      int androidVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        androidVersion = androidInfo.version.sdkInt;
      }

      // 🔹 Request permissions
      if (Platform.isAndroid) {
        if (androidVersion >= 30) {
          final status = await Permission.manageExternalStorage.request();
          if (!status.isGranted) {
            throw Exception("Storage permission not granted (Scoped Storage)");
          }
        } else {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            throw Exception("Storage permission not granted");
          }
        }
      } else if (Platform.isIOS) {
        final status = await Permission.photosAddOnly.request();
        if (!status.isGranted) {
          throw Exception("Photos permission not granted");
        }
      }

      // 🔹 Get directory
      Directory dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download'); // Public Downloads
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // 🔹 File path
      String fileName = "photo_${DateTime.now().millisecondsSinceEpoch}.jpg";
      String savePath = "${dir.path}/$fileName";

      // 🔹 Download file
      Dio dio = Dio();
      await dio.download(imageUrl, savePath);

      print("✅ Image saved at $savePath");
    } catch (e) {
      print("❌ Error downloading image: $e");
      rethrow;
    }
  }
}
