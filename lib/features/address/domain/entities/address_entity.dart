import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String name;
  final String address;
  final bool isDefault;
  final DateTime? createdAt;

  const AddressEntity({
    this.id,
    required this.name,
    required this.address,
    required this.isDefault,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, address, isDefault, createdAt];
}
