class UpdateAccountDto {
  final String name;
  final String phone;
  final String address;
  final String image;

  UpdateAccountDto({
    required this.name,
    required this.phone,
    required this.address,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "address": address,
      "image": image,
    };
  }
}