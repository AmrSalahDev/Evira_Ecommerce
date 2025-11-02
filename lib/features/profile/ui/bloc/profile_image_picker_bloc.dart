import 'dart:io';

import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/profile/domain/usecases/profile_image_picker_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'profile_image_picker_event.dart';
part 'profile_image_picker_state.dart';

@injectable
class ProfileImagePickerBloc
    extends Bloc<ProfileImagePickerEvent, ProfileImagePickerState> {
  final ProfileImagePickerUsecase profileImagePickerUsecase;
  ProfileImagePickerBloc(this.profileImagePickerUsecase)
    : super(ProfileImagePickerInitial()) {
    on<PickImageEvent>((event, emit) async {
      emit(ProfileImagePickerLoading());
      await AppUtils.handleCode(
        code: () async {
          final File? image = await profileImagePickerUsecase.call();
          if (image != null) {
            emit(ProfileImagePicked(image));
          } else {
            emit(ProfileImagePickerInitial());
          }
        },
        onNoInternet: (message) {
          emit(ProfileImagePickerError(message));
        },
        onError: (message) {
          emit(ProfileImagePickerError(message));
        },
      );
    });
  }
}
