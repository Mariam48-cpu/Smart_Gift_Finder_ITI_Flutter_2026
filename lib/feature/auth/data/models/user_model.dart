import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    super.name,
    required super.email,
  });
  factory UserModel.fromFirebase({
    required String uid,
    String? name,
    required String email,
  }) {
    return UserModel(
      uid: uid,
      name: name,
      email: email,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
    );
  }
}