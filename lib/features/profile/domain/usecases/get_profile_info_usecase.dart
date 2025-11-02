import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:evira_e_commerce/features/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileInfoUsecase {
  final ProfileRepo profileRepo;
  GetProfileInfoUsecase(this.profileRepo);
  Future<ProfileEntity?> call() => profileRepo.getProfileInfo();
}
