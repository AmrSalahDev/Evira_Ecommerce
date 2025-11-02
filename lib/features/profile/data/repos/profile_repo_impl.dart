import 'dart:io';

import 'package:evira_e_commerce/features/profile/domain/datasources/profile_remote_datasource.dart';
import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:evira_e_commerce/features/profile/domain/repos/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDatasource _profileRemoteDataSource;

  ProfileRepoImpl(this._profileRemoteDataSource);

  @override
  Future<void> updateUserImage({required File imageFile}) async {
    return await _profileRemoteDataSource.updateUserImage(imageFile: imageFile);
  }

  @override
  Future<File?> profileImagePicker() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  @override
  String? getUserImage() {
    return _profileRemoteDataSource.getUserImage();
  }

  @override
  Future<ProfileEntity?> getProfileInfo() async {
    return await _profileRemoteDataSource.getProfileInfo();
  }
}
