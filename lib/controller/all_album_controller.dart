import 'dart:math';
import 'package:photobackup/utils/file_indexes.dart';

class AllAlbumController extends GetxController{
  final List<Color> folderAccentColors = [
    AppColors.cottonCandy,
    AppColors.lavenderBlue,
    AppColors.lightCyan,
    AppColors.lavenderBlue,
    AppColors.lightWarm,
    AppColors.softViolet,
    AppColors.cottonCandy,
    AppColors.lavenderBlue,
  ];

  final List<Color> folderMainColors = [
    AppColors.rosePink.withValues(alpha: 0.7),
    AppColors.primaryColor,
    AppColors.brightTeal,
    AppColors.primaryColor,
    AppColors.peachColor,
    AppColors.softMagenta,
    AppColors.rosePink.withValues(alpha: 0.7),
    AppColors.primaryColor,
  ];
  List<String> foldersName = [
    "Vacations",
    "Birthdays",
    "Weddings",
    "Concerts",
    "Road Trips",
    "Reunions",
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
}