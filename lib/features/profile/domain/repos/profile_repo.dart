import 'dart:io';

import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepo {
  Future<void> updateUserImage({required File imageFile});
  Future<File?> profileImagePicker();
  String? getUserImage();
  Future<ProfileEntity?> getProfileInfo();
}
