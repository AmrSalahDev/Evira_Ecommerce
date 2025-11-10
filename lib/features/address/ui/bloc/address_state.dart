part of 'address_bloc.dart';

class AddressState extends Equatable {
  final List<AddressEntity> addresses;
  final String addressDetails;
  final String errorMessage;
  final bool isFetchingAddresses;
  final bool isAddingAddress;
  final bool isFetchingCurrentAddress;

  const AddressState(
    this.addresses,
    this.addressDetails,
    this.errorMessage,
    this.isFetchingAddresses,
    this.isAddingAddress,
    this.isFetchingCurrentAddress,
  );

  @override
  List<Object> get props => [
    addresses,
    addressDetails,
    errorMessage,
    isFetchingAddresses,
    isAddingAddress,
    isFetchingCurrentAddress,
  ];

  AddressState copyWith({
    List<AddressEntity>? addresses,
    String? addressDetails,
    String? errorMessage,
    bool? isFetchingAddresses,
    bool? isAddingAddress,
    bool? isFetchingCurrentAddress,
  }) {
    return AddressState(
      addresses ?? this.addresses,
      addressDetails ?? this.addressDetails,
      errorMessage ?? this.errorMessage,
      isFetchingAddresses ?? this.isFetchingAddresses,
      isAddingAddress ?? this.isAddingAddress,
      isFetchingCurrentAddress ?? this.isFetchingCurrentAddress,
    );
  }
}
