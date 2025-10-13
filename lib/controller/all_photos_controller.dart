import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:photobackup/constants/assets_path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/imageModel.dart';
import '../services/image_service.dart';
import '../view/home_page/choose_album.dart';

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

      Get.to(()=>ChooseAlbum());
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








}

