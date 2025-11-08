part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class UpdateProfileLoading extends EditProfileState {}

final class UpdateProfileSuccess extends EditProfileState {}

final class UpdateProfileError extends EditProfileState {
  final String message;
  const UpdateProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
