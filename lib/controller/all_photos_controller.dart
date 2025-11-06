import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:photobackup/constants/assets_path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_colors.dart';
import '../models/imageModel.dart';
import '../models/upload_item_model.dart';
import '../services/image_service.dart';
import '../view/home_page/choose_album.dart';
import '../widgets/home_widgets/dialog_box.dart';

class AllPhotosController extends GetxController {
  List<String> images = [
    AppImages.image1,
    AppImages.image2,
    AppImages.image3,
    AppImages.image4,
    AppImages.image5,
    AppImages.image6,
    AppImages.image7,
    AppImages.image6,
    AppImages.image5,
  ];
}


class ImageUploadController extends GetxController {
  final currentUserId = Supabase.instance.client.auth.currentUser?.id;
  var selectedFiles = <XFile>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var images = <ImageModel>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserImages();
  }

  Future<void> pickAndCompressImages(BuildContext context) async {
    final pickedFiles = await AlbumService.instance.pickMultipleImages();
    if (pickedFiles.isEmpty) return;

    for (var file in pickedFiles) {
      final compressed = await AlbumService.instance.compressImage(file);
      if (compressed != null) {
        selectedFiles.add(compressed);
      }
    }

    if (selectedFiles.isNotEmpty) {
      Get.snackbar(
        "Images Ready",
        "${selectedFiles.length} compressed image(s) selected",
        snackPosition: SnackPosition.BOTTOM,
      );

      AppDialogBox.imageUploadedDialogue(

          context: context,
          onConfirm: () => Get.to(()=>ChooseAlbum()),
          iconPath: AppIcons.imageUploadedIcon,
          title: 'Image Uploaded',
          content: 'Your image has been successfully uploaded!',
          confirmText: 'Add to Album',
          textColor: AppColors.whiteColor,
          cancelText: '',
          borderColor: AppColors.primaryColor,
          btnColor: AppColors.primaryColor
      );

    }
  }

  /// Upload after user decides album OR none
  Future<void> uploadSelectedImages({required String albumId}) async {
    if (selectedFiles.isEmpty) return;

    final userId = currentUserId; // replace with your auth logic

    for (var xfile in selectedFiles) {
      final file = File(xfile.path);
      await AlbumService.instance.uploadImageToAlbum(
        userId: userId!,
        file: file,
        albumId : albumId,

      );
    }

    Get.snackbar(
      "Upload Complete",
      "Uploaded ${selectedFiles.length} images",
      snackPosition: SnackPosition.BOTTOM,
    );

    clearSelection();
  }

  void clearSelection() {
    selectedFiles.clear();
  }




  Future<void> fetchUserImages() async {
    try {
      isLoading.value = true;
      error.value = '';
      final result = await AlbumService.instance.fetchUserImages(currentUserId!);
      images.assignAll(result);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> deleteImage(String imageId, String imageUrl) async {
    try {
      await AlbumService.instance.deleteImage(imageId, imageUrl);
      images.removeWhere((img) => img.id == imageId);
      Get.snackbar("Success", "Image deleted successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }



  /// Share image function
  Future<void> shareImage(String imageUrl, {String? imageName}) async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {

        final tempDir = await getTemporaryDirectory();
        final fileName = imageName ?? 'shared_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final file = File('${tempDir.path}/$fileName');

        await file.writeAsBytes(response.bodyBytes);

        if (await file.exists() && await file.length() > 0) {
          final result = await Share.shareXFiles(
            [XFile(file.path)],
            text: 'Check out this image!',
          );

          // Optional: Check share result
          if (result.status == ShareResultStatus.success) {
            Get.snackbar(
              "Success",
              "Image shared successfully",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } else {
          throw Exception('File verification failed');
        }
      } else {
        throw Exception('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to share image: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading.value = false;
    }
  }







}



