import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/profile/domain/entities/profile_entity.dart';
import 'package:evira_e_commerce/features/profile/domain/usecases/get_profile_info_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

@injectable
class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final GetProfileInfoUsecase getProfileInfoUsecase;
  ProfileInfoBloc(this.getProfileInfoUsecase) : super(ProfileInfoInitial()) {
    on<GetProfileInfoEvent>((event, emit) async {
      emit(ProfileInfoLoading());
      AppUtils.handleCode(
        code: () async {
          final result = await getProfileInfoUsecase.call();
          if (result == null) return;
          emit(ProfileInfoLoaded(result));
        },
        onNoInternet: (message) {
          emit(ProfileInfoError(message));
        },
        onError: (message) {
          emit(ProfileInfoError(message));
        },
      );
    });
  }
}
