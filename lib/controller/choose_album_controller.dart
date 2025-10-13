import 'package:get/get.dart';
import '../models/albumModel.dart';
import '../models/imageModel.dart';
import '../services/album_service.dart';
import 'package:flutter/material.dart';

class ChooseAlbumController extends GetxController {
  var albums = <AlbumModel>[].obs;
  var selectedAlbumImages = <ImageModel>[].obs;
  var isLoading = false.obs;
  var selectedAlbumIndex = (-1).obs;
  var imageCount = 0.obs;
  RxMap<String, int> albumImageCounts = <String, int>{}.obs;

  // Text field controller
  final TextEditingController albumNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAlbums();
    loadAllAlbumImageCounts();
  }

  Future<void> fetchAlbums() async {
    try {
      isLoading.value = true;
      final result = await AlbumService.instance.getAlbums();
      albums.assignAll(result);
      print("Album Length: ${albums.length}");
    } catch (e) {
      print("Error fetching albums: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createAlbum() async {
    final name = albumNameController.text.trim();
    if (name.isEmpty) return;

    await AlbumService.instance.createAlbum(name);
    albumNameController.clear();
    await fetchAlbums(); // refresh album list
    Get.back(); // close dialog
  }

  ///Fetch Al
  Future<void> fetchAlbumImages(String albumId) async {
    try {
      isLoading.value = true;

      final images = await AlbumService.instance.getImagesByAlbum(albumId);
      selectedAlbumImages.assignAll(images);

      print("Fetched ${images.length} images for album: $albumId");
    } catch (e) {
      print("Error fetching album images: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> loadAllAlbumImageCounts() async {
    try {
      final allCounts = await AlbumService.instance.getImageCountsForAllAlbums();
      albumImageCounts.value = allCounts;
    } catch (e) {
      print("Error loading image counts: $e");
    }
  }

  int getImageCountForAlbum(String albumId) {
    return albumImageCounts[albumId] ?? 0;
  }



}
