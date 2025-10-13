class UserModel {
  final String userId;
  final String name;
  final String email;
  final String profilePic;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePic,
  });

  // Convert UserModel -> Map (for Supabase insert)
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'profile_pic': profilePic,
    };
  }

  // Convert Map -> UserModel (for fetching from Supabase)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      profilePic: json['profile_pic'],
    );
  }
}
