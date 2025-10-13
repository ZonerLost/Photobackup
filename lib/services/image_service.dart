import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/imageModel.dart';

class AlbumService {
  static final AlbumService instance = AlbumService._internal();
  AlbumService._internal();
  final SupabaseClient _supabase = Supabase.instance.client;


  /// Pick Single image From Gallery
  Future<File?> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    return File(picked.path);
  }


  /// Compress image
  Future<XFile?> compressImage(File file) async {
    final targetPath = "${file.path}_compressed.jpg";
    return await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 70,
    );
  }



  /// pick multiple Images From Gallery
  Future<List<File>> pickMultipleImages() async {
    final picked = await ImagePicker().pickMultiImage();
    if (picked.isEmpty) return [];
    return picked.map((xfile) => File(xfile.path)).toList();
  }




  /// Upload image to Supabase storage & save record in DB
  Future<String?> uploadImageToAlbum({
    required String userId,
    required File file,
    required String albumId, // album is now required
  }) async {
    try {
      final fileName = "${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}";

      /// 1. Upload file to Supabase Storage
      await _supabase.storage.from('images').upload(fileName, file);

      /// 2. Get public URL
      final publicUrl = _supabase.storage.from('images').getPublicUrl(fileName);

      /// 3. Insert into images table
      final imageInsert = await _supabase.from("images").insert({
        "user_id": userId,
        "image_url": publicUrl,
      }).select().single();

      final imageId = imageInsert['id'] as String;

      /// 4. Link the image to the selected album
      await _supabase.from("album_images").insert({
        "album_id": albumId,
        "image_id": imageId,
      });

      return publicUrl;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }



 /// Fetch all images of the Current user
  Future<List<ImageModel>> fetchUserImages(String userId) async {
    final response =
    await _supabase.from('images').select().eq('user_id', userId);

    final data = response as List;

    return data
        .map((e) => ImageModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }





  /// Fetch images of an album
  Future<List<ImageModel>> fetchImages(String albumId) async {
    final response =
        await _supabase.from('images').select().eq('album_id', albumId);

    return (response as List)
        .map((e) => ImageModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }




  Future<void> deleteImage(String imageId, String imageUrl) async {
    try {
      // 1. Extract file path from the URL (or better: store file_path in DB on upload)
      final Uri uri = Uri.parse(imageUrl);
      final String filePath = uri.pathSegments.last;

      // 2. Delete from storage
      final removedFiles = await _supabase.storage
          .from('images') // 👈 replace with actual bucket name
          .remove([filePath]);

      if (removedFiles.isEmpty) {
        throw Exception("Error deleting from storage: file not found");
      }

      // 3. Delete from images table (album_images rows cascade)
      await _supabase
          .from('images')
          .delete()
          .eq('id', imageId);
    } catch (e) {
      throw Exception("Delete failed: $e");
    }
  }



}
