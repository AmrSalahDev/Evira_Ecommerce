part of 'profile_image_bloc.dart';

sealed class ProfileImageState extends Equatable {
  const ProfileImageState();

  @override
  List<Object> get props => [];
}

final class ProfileImageInitial extends ProfileImageState {}

final class ProfileImageLoading extends ProfileImageState {}

final class ProfileImageLoaded extends ProfileImageState {
  final String imageUrl;
  const ProfileImageLoaded(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

final class ProfileImageError extends ProfileImageState {
  final String message;
  const ProfileImageError(this.message);

  @override
  List<Object> get props => [message];
}
