import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,

    required super.name,
    required super.address,
    required super.isDefault,
    required super.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'].toString(),
      name: json['name'],
      address: json['address'],
      isDefault: json['is_default'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson(String userId) {
    return {
      'user_id': userId,
      'name': name,
      'address': address,
      'is_default': isDefault,
    };
  }
}
