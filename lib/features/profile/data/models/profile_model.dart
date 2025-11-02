import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String fullname;
  final String nickname;
  final String dateOfBirth;
  final String anotherEmail;
  final String phone;
  final String gender;
  final String profileImage;

  ProfileModel({
    required this.fullname,
    required this.nickname,
    required this.dateOfBirth,
    required this.anotherEmail,
    required this.phone,
    required this.gender,
    required this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullname: json['fullname'],
      nickname: json['nickname'],
      dateOfBirth: json['dateOfBirth'],
      anotherEmail: json['anotherEmail'],
      phone: json['phone'],
      gender: json['gender'],
      profileImage: json['profileImage'],
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      fullname: fullname,
      nickname: nickname,
      dateOfBirth: dateOfBirth,
      anotherEmail: anotherEmail,
      phone: phone,
      gender: gender,
      profileImage: profileImage,
    );
  }
}
