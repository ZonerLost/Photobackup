class AlbumModel {
  final String id;       // uuid in Supabase → String in Dart
  final String userId;   // foreign key uuid → String in Dart
  final String name;
  final DateTime createdAt;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
