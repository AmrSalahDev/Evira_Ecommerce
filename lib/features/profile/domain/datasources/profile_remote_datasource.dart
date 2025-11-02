import 'dart:io';

import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRemoteDatasource {
  Future<void> updateUserImage({required File imageFile});
  String? getUserImage();
  Future<ProfileEntity?> getProfileInfo();
}
