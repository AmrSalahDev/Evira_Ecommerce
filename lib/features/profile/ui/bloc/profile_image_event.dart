part of 'profile_image_bloc.dart';

sealed class ProfileImageEvent extends Equatable {
  const ProfileImageEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserImage extends ProfileImageEvent {
  final File imageFile;
  const UpdateUserImage({required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}

class GetUserImage extends ProfileImageEvent {}
