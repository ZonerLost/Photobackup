class ImageModel {
  final String id;
  final String userId;
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
  });

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id']?.toString() ?? '',          // ensure not null
      userId: map['user_id']?.toString() ?? '', // ensure not null
      imageUrl: map['image_url']?.toString() ?? '', // ensure not null
    );
  }
}
