import 'dart:math';
import 'package:photobackup/services/database_service.dart';
import 'package:photobackup/services/image_service.dart';
import 'package:photobackup/utils/file_indexes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/imageModel.dart';
import '../models/userModel.dart';

class HomePageController extends GetxController {
  final currentUserId = Supabase.instance.client.auth.currentUser?.id;
  @override
  void onInit() {
    super.onInit();
    fetchUser(currentUserId!);
  }


  List<String> images = [
    AppImages.image1,
    AppImages.image2,
    AppImages.image3,
    AppImages.image4,
    AppImages.image5,
    AppImages.image6,
    AppImages.image7,
  ];
  final List<Color> folderAccentColors = [
    AppColors.cottonCandy,
    AppColors.lavenderBlue,
    AppColors.lightCyan,
    AppColors.lavenderBlue,
    AppColors.lightWarm,
    AppColors.softViolet,
  ];

  final List<Color> folderMainColors = [
    AppColors.rosePink.withValues(alpha: 0.7),
    AppColors.primaryColor,
    AppColors.brightTeal,
    AppColors.primaryColor,
    AppColors.peachColor,
    AppColors.softMagenta,
  ];

  List<String> foldersName = [
    "Vacations",
    "Birthdays",
    "Concerts",
    "Road Trips",
    "Reunions"
    "Road Trips",
    "Weddings",
    "Concerts",
    "Birthdays",
  ];

  List<String> photosCount = [
    "124 Photos",
    "78 Photos",
    "150 Photos",
    "56 Photos",
    "89 Photos",
    "42 Photos",
    "142 Photos",
    "242 Photos",
    "32 Photos",
  ];




  Rx<UserModel?> user = Rx<UserModel?>(null); // reactive user model
  RxBool isLoading = false.obs;

  Future<void> fetchUser(String userId) async {
    try {
      isLoading.value = true;
      final result = await DatabaseService.instance.getUserById(userId);
      user.value = result;
    } catch (e) {
      print("Error fetching user: $e");
    } finally {
      isLoading.value = false;
    }
  }





  var imagesUpload = <ImageModel>[].obs;


  Future<void> loadAlbumImages(String albumId) async {
    try {
      isLoading.value = true;
      imagesUpload.value = await AlbumService.instance.fetchImages(albumId);
    } catch (e) {
      print("Error loading images: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /*Future<void> addImage(String albumId) async {
    final file = await AlbumService.instance.pickImage();
    if (file == null) return;

    final compressed = await AlbumService.instance.compressImage(file);
    if (compressed == null) return;

    final uploaded = await AlbumService.instance.uploadImage(userId: currentUserId!, albumId: albumId, file: compressed);

    if (uploaded != null) {
      images.add(uploaded.toString()); // ✅ instantly show in UI
    }
  }*/



}


