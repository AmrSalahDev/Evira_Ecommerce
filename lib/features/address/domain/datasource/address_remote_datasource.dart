import 'package:evira_e_commerce/features/address/data/models/address_model.dart';

abstract class AddressRemoteDatasource {
  Future<void> addAddress(AddressModel address);
  Future<List<AddressModel>> getAddresses();
}
