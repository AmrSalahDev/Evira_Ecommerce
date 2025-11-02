part of 'profile_info_bloc.dart';

sealed class ProfileInfoState extends Equatable {
  const ProfileInfoState();

  @override
  List<Object> get props => [];
}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

final class ProfileInfoLoaded extends ProfileInfoState {
  final ProfileEntity profile;
  const ProfileInfoLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

final class ProfileInfoError extends ProfileInfoState {
  final String message;
  const ProfileInfoError(this.message);

  @override
  List<Object> get props => [message];
}
