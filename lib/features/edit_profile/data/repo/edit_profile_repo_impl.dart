import 'package:evira_e_commerce/features/edit_profile/domain/repo/edit_profile_repo.dart';
import 'package:evira_e_commerce/features/profile/data/models/profile_model.dart';
import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> updateProfileInfo({required ProfileEntity profile}) async {
    final profileModel = ProfileModel(
      fullname: profile.fullname,
      nickname: profile.nickname,
      dateOfBirth: profile.dateOfBirth,
      anotherEmail: profile.anotherEmail,
      phone: profile.phone,
      gender: profile.gender,
      profileImage: profile.profileImage,
    );
    await supabase.auth.updateUser(UserAttributes(data: profileModel.toJson()));
    await supabase.auth.refreshSession();
  }
}
