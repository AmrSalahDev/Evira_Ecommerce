import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class AddressRepo {
  Future<void> addAddress(AddressEntity address);
  Future<List<AddressEntity>> getAddresses();
  Future<String> getCurrentAddressDetails(LatLng position);
}
