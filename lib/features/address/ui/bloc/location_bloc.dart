import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/address/domain/usecases/get_current_location_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

part 'location_event.dart';
part 'location_state.dart';

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUsecase getCurrentLocationUsecase;
  LocationBloc(this.getCurrentLocationUsecase) : super(LocationInitial()) {
    on<GetCurrentLocationEvent>((event, emit) async {
      emit(LocationLoading());
      await AppUtils.handleCode(
        code: () async {
          final position = await getCurrentLocationUsecase.call();
          emit(LocationLoaded(LatLng(position.latitude, position.longitude)));
        },
        onNoInternet: (message) {
          emit(LocationError(message));
        },
        onError: (message) {
          emit(LocationError(message));
        },
      );
    });
  }
}
