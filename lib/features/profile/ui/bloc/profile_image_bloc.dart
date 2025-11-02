import 'dart:io';

import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/profile/domain/usecases/get_user_image_usecase.dart';
import 'package:evira_e_commerce/features/profile/domain/usecases/update_user_image_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'profile_image_event.dart';
part 'profile_image_state.dart';

@injectable
class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  final UpdateUserImageUsecase updateUserImageUsecase;
  final GetUserImageUsecase getUserImageUsecase;

  ProfileImageBloc(this.updateUserImageUsecase, this.getUserImageUsecase)
    : super(ProfileImageInitial()) {
    on<UpdateUserImage>((event, emit) async {
      await AppUtils.handleCode(
        code: () async {
          await updateUserImageUsecase.call(imageFile: event.imageFile);
        },
        onNoInternet: (message) {
          emit(ProfileImageError(message));
        },
        onError: (message) {
          emit(ProfileImageError(message));
        },
      );
    });

    on<GetUserImage>((event, emit) {
      AppUtils.handleCode(
        code: () async {
          final String? url = getUserImageUsecase.call();
          if (url == null) {
            return;
          }
          emit(ProfileImageLoaded(url));
        },
        onNoInternet: (message) {
          emit(ProfileImageError(message));
        },
        onError: (message) {
          emit(ProfileImageError(message));
        },
      );
    });
  }
}
