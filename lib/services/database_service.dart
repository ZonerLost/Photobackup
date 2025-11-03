import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/userModel.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();
  DatabaseService._internal();
  final supabase = Supabase.instance.client;

  /*Future<void> storeUser(UserModel user) async {
    try {
      await supabase.from('users').insert(user.toJson());
    } catch (e) {
      print("Error saving user: $e");
      rethrow;
    }
  }*/

  Future<void> storeUser(UserModel user) async {
    try {
      final existing = await supabase
          .from('users')
          .select()
          .eq('email', user.email)
          .maybeSingle();

      if (existing == null) {
        await supabase.from('users').insert(user.toJson());
      } else {
        await supabase
            .from('users')
            .update(user.toJson())
            .eq('email', user.email);
      }
    } catch (e) {
      print("Error saving user: $e");
      rethrow;
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    final response =
        await supabase.from('users').select().eq('user_id', userId).single();

    if (response != null) {
      return UserModel.fromJson(response);
    }
    return null;
  }
}
