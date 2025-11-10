import 'package:evira_e_commerce/core/utils/location_utils.dart';
import 'package:evira_e_commerce/features/address/data/models/address_model.dart';
import 'package:evira_e_commerce/features/address/domain/datasource/address_remote_datasource.dart';
import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:evira_e_commerce/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@LazySingleton(as: AddressRepo)
class AddressRepoImpl implements AddressRepo {
  final AddressRemoteDatasource addressRemoteDatasource;
  AddressRepoImpl(this.addressRemoteDatasource);

  @override
  Future<void> addAddress(AddressEntity address) async {
    final addressModel = AddressModel(
      id: address.id,
      name: address.name,
      address: address.address,
      isDefault: address.isDefault,
      createdAt: address.createdAt,
    );

    await addressRemoteDatasource.addAddress(addressModel);
  }

  @override
  Future<List<AddressEntity>> getAddresses() async {
    return await addressRemoteDatasource.getAddresses();
  }

  @override
  Future<String> getCurrentAddressDetails(LatLng position) async {
    final address = await LocationUtils.getAddressFromLatLng(position);
    return '${address['street']}';
  }
}
