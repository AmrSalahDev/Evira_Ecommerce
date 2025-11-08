import 'package:evira_e_commerce/features/edit_profile/domain/repo/edit_profile_repo.dart';
import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUsecase {
  final EditProfileRepo editProfileRepo;
  UpdateProfileUsecase({required this.editProfileRepo});

  Future<void> call({required ProfileEntity profile}) =>
      editProfileRepo.updateProfileInfo(profile: profile);
}
