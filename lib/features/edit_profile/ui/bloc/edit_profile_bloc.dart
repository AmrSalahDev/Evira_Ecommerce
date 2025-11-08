import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/edit_profile/domain/usecases/update_profile_usecase.dart';
import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;
  EditProfileBloc(this.updateProfileUsecase) : super(EditProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) async {
      emit(UpdateProfileLoading());
      await AppUtils.handleCode(
        code: () async {
          await updateProfileUsecase.call(profile: event.profile);
          emit(UpdateProfileSuccess());
        },
        onNoInternet: (message) {
          emit(UpdateProfileError(message: message));
        },
        onError: (message) {
          emit(UpdateProfileError(message: message));
        },
      );
    });
  }
}
