part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends EditProfileEvent {
  final ProfileEntity profile;
  const UpdateProfileEvent({required this.profile});

  @override
  List<Object> get props => [profile];
}
