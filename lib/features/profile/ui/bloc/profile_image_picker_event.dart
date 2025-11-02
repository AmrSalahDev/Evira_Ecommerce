part of 'profile_image_picker_bloc.dart';

sealed class ProfileImagePickerEvent extends Equatable {
  const ProfileImagePickerEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends ProfileImagePickerEvent {
  final File? imageFile;
  const PickImageEvent({this.imageFile});

  @override
  List<Object?> get props => [imageFile];
}
