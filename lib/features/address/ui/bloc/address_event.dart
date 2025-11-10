part of 'address_bloc.dart';

sealed class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddAddressEvent extends AddressEvent {
  final AddressEntity address;
  const AddAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

class GetCurrentAddressDetailsEvent extends AddressEvent {
  final LatLng addressDetails;

  const GetCurrentAddressDetailsEvent(this.addressDetails);

  @override
  List<Object> get props => [addressDetails];
}

class GetAddressesEvent extends AddressEvent {}

class UpdateAddressEvent extends AddressEvent {
  final AddressEntity address;

  const UpdateAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  const DeleteAddressEvent(this.addressId);

  @override
  List<Object> get props => [addressId];
}
