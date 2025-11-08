import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';

abstract class EditProfileRepo {
  Future<void> updateProfileInfo({required ProfileEntity profile});
}
