import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:evira_e_commerce/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUsecaes {
  final AddressRepo addressRepo;
  AddAddressUsecaes(this.addressRepo);
  Future<void> call(AddressEntity address) => addressRepo.addAddress(address);
}
