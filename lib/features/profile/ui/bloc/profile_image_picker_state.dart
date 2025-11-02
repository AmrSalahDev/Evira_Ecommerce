part of 'profile_image_picker_bloc.dart';

sealed class ProfileImagePickerState extends Equatable {
  const ProfileImagePickerState();

  @override
  List<Object> get props => [];
}

final class ProfileImagePickerInitial extends ProfileImagePickerState {}

final class ProfileImagePickerLoading extends ProfileImagePickerState {}

final class ProfileImagePicked extends ProfileImagePickerState {
  final File imageFile;
  const ProfileImagePicked(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

final class ProfileImagePickerError extends ProfileImagePickerState {
  final String message;
  const ProfileImagePickerError(this.message);

  @override
  List<Object> get props => [message];
}
