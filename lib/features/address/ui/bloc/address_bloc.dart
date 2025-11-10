import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/address/domain/usecases/add_address_usecaes.dart';
import 'package:evira_e_commerce/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:evira_e_commerce/features/address/domain/usecases/get_current_address_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

part 'address_event.dart';
part 'address_state.dart';

@injectable
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddAddressUsecaes addAddressUsecaes;
  final GetAddressesUsecase getAddressesUsecase;
  final GetCurrentAddressDetailsUsecase getCurrentAddressDetailsUsecase;

  AddressBloc(
    this.addAddressUsecaes,
    this.getAddressesUsecase,
    this.getCurrentAddressDetailsUsecase,
  ) : super(AddressState([], '', '', false, false, false)) {
    on<AddAddressEvent>((event, emit) async {
      emit(state.copyWith(isAddingAddress: true));
      await AppUtils.handleCode(
        code: () async {
          await addAddressUsecaes(event.address);
          emit(state.copyWith(isAddingAddress: false));
        },
        onNoInternet: (messsage) {
          emit(state.copyWith(errorMessage: messsage, isAddingAddress: false));
        },
        onError: (message) {
          emit(state.copyWith(errorMessage: message, isAddingAddress: false));
        },
      );
    });

    on<GetAddressesEvent>((event, emit) async {
      emit(state.copyWith(isFetchingAddresses: true));
      await AppUtils.handleCode(
        code: () async {
          final addresses = await getAddressesUsecase();
          emit(
            state.copyWith(addresses: addresses, isFetchingAddresses: false),
          );
        },
        onNoInternet: (messsage) {
          emit(
            state.copyWith(errorMessage: messsage, isFetchingAddresses: false),
          );
        },
        onError: (message) {
          emit(
            state.copyWith(errorMessage: message, isFetchingAddresses: false),
          );
        },
      );
    });

    on<GetCurrentAddressDetailsEvent>((event, emit) async {
      emit(state.copyWith(isFetchingCurrentAddress: true));
      await AppUtils.handleCode(
        code: () async {
          final address = await getCurrentAddressDetailsUsecase(
            event.addressDetails,
          );
          emit(
            state.copyWith(
              addressDetails: address,
              isFetchingCurrentAddress: false,
            ),
          );
        },
        onNoInternet: (messsage) {
          emit(
            state.copyWith(
              errorMessage: messsage,
              isFetchingCurrentAddress: false,
            ),
          );
        },
        onError: (message) {
          emit(
            state.copyWith(
              errorMessage: message,
              isFetchingCurrentAddress: false,
            ),
          );
        },
      );
    });
  }
}
