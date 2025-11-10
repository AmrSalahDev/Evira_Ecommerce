import 'package:evira_e_commerce/features/address/domain/repo/address_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class GetCurrentAddressDetailsUsecase {
  final AddressRepo addressRepo;

  GetCurrentAddressDetailsUsecase(this.addressRepo);

  Future<String> call(LatLng position) =>
      addressRepo.getCurrentAddressDetails(position);
}
