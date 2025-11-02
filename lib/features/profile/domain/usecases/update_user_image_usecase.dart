import 'dart:io';

import 'package:evira_e_commerce/features/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserImageUsecase {
  final ProfileRepo profileRepo;

  UpdateUserImageUsecase({required this.profileRepo});

  Future<void> call({required File imageFile}) =>
      profileRepo.updateUserImage(imageFile: imageFile);
}
