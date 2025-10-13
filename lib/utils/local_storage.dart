// import 'package:get_storage/get_storage.dart';
// import 'package:photobackup/utils/file_indexes.dart';
//
// class LocalStorage {
//   /// Private constructor
//   LocalStorage._init();
//   static final GetStorage _storage = GetStorage();
//   static LocalStorage? _instance;
//
//   /// Keys
//   final String _userId = 'userId';
//
//   /// Singleton instance
//   static LocalStorage get instance {
//     _instance ??= LocalStorage._init();
//     return _instance!;
//   }
//
//   /// ================== Bearer Token ==================
//   String get userId => _storage.read(_userId) ?? '';
//
//   Future<void> setUserId(String token) async {
//     await _storage.write(_userId, token);
//   }
//
//
//
//   /// ================== Utilities ==================
//   Future<void> eraseStorage() async {
//     await _storage.remove(_userId);
//     showConsole('Storage Erased');
//   }
// }
