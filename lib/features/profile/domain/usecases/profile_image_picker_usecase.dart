import 'dart:io';

import 'package:evira_e_commerce/features/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileImagePickerUsecase {
  final ProfileRepo profileRepo;

  ProfileImagePickerUsecase({required this.profileRepo});

  Future<File?> call() => profileRepo.profileImagePicker();
}
