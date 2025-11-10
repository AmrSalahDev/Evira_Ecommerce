import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:evira_e_commerce/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressesUsecase {
  final AddressRepo addressRepo;
  GetAddressesUsecase(this.addressRepo);
  Future<List<AddressEntity>> call() => addressRepo.getAddresses();
}
