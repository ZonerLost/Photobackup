import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/albumModel.dart';
import '../models/imageModel.dart';


class AlbumService {
  static final AlbumService instance = AlbumService._internal();
  AlbumService._internal();

  final supabase = Supabase.instance.client;

  Future<List<AlbumModel>> getAlbums() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");
      print("service function start");
      final response = await supabase
          .from('albums')
          .select()
          .eq('user_id', user.id)
          .order('created_at');
      final List data = response as List;

      return data.map((album) => AlbumModel.fromJson(album)).toList();
    } catch (e) {
      throw Exception("Error fetching albums: $e");
    }
  }


  Future<void> createAlbum(String name) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      await supabase.from('albums').insert({
        'name': name,
        'user_id': user.id, // ✅ assign current user
      });
    } catch (e) {
      throw Exception("Error creating album: $e");
    }
  }




  Future<List<ImageModel>> getImagesByAlbum(String albumId) async {
    final result = await supabase
        .from('album_images')
        .select('images(id, image_url)')
        .eq('album_id', albumId);

    final List data = result as List;

    return data
        .map((e) => ImageModel.fromMap(e['images']))
        .toList();
  }



  Future<Map<String, int>> getImageCountsForAllAlbums() async {
    try {
      final response = await supabase
          .from('album_images')
          .select('album_id');

      Map<String, int> counts = {};
      for (var row in response) {
        String albumId = row['album_id'].toString();
        counts[albumId] = (counts[albumId] ?? 0) + 1;
      }

      print("Album image counts: $counts");
      return counts;
    } catch (e) {
      print("Error fetching image counts: $e");
      return {};
    }
  }




}
