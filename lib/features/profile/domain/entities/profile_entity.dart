class ProfileEntity {
  final String fullname;
  final String nickname;
  final String dateOfBirth;
  final String anotherEmail;
  final String phone;
  final String gender;
  final String profileImage;

  ProfileEntity({
    required this.fullname,
    required this.nickname,
    required this.dateOfBirth,
    required this.anotherEmail,
    required this.phone,
    required this.gender,
    required this.profileImage,
  });

  ProfileEntity.empty({
    this.fullname = '',
    this.nickname = '',
    this.dateOfBirth = '',
    this.anotherEmail = '',
    this.phone = '',
    this.gender = '',
    this.profileImage = '',
  });
}
