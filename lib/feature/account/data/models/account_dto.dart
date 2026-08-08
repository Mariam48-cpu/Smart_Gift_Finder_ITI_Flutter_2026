import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';

class AccountDto {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String imageUrl;
  final dynamic birthday;

  const AccountDto({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.imageUrl,
    required this.birthday,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      birthday: json['birthday'] ?? '',
    );
  }

  factory AccountDto.fromEntity(AccountEntity entity) {
    return AccountDto(
      uid: entity.uid,
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      address: entity.address,
      imageUrl: entity.imageUrl,
      birthday: entity.birthday,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'imageUrl': imageUrl,
      'birthday': birthday,
    };
  }

  AccountEntity toEntity() {
    return AccountEntity(
      uid: uid,
      name: name,
      phone: phone,
      email: email,
      address: address,
      imageUrl: imageUrl,
      birthday: birthday,
    );
  }
}
