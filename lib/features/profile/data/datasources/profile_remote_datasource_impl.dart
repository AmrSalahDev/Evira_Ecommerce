import 'dart:io';

import 'package:evira_e_commerce/features/profile/data/models/profile_model.dart';
import 'package:evira_e_commerce/features/profile/domain/datasources/profile_remote_datasource.dart';
import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ProfileRemoteDatasource)
class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> updateUserImage({required File imageFile}) async {
    final String uid = supabase.auth.currentUser!.id;
    final String filePath = "$uid/profile.png";

    await supabase.storage
        .from('profile_images')
        .upload(
          filePath,
          imageFile,
          fileOptions: const FileOptions(upsert: true),
        );

    // Get public URL
    final String publicUrl = supabase.storage
        .from('profile_images')
        .getPublicUrl(filePath);

    await supabase.auth.updateUser(
      UserAttributes(data: {'profileImage': publicUrl}),
    );
  }

  @override
  String? getUserImage() {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final url = user.userMetadata?['profileImage'];
    if (url == null) return null;

    // Force refresh cached image url by appending timestamp
    return "$url?time=${DateTime.now().millisecondsSinceEpoch}";
  }

  @override
  Future<ProfileEntity?> getProfileInfo() async {
    final user = supabase.auth.currentUser;
    final metaData = user?.userMetadata;
    if (user == null || metaData == null) return null;

    return ProfileModel.fromJson(metaData).toEntity();
  }
}
