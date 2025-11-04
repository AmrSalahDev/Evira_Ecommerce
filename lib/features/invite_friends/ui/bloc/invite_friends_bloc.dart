import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/usecases/get_friends_usecase.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/usecases/send_email_usecase.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/usecases/send_sms_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/enum/invite_method.dart';
import 'package:injectable/injectable.dart';
part 'invite_friends_event.dart';
part 'invite_friends_state.dart';

@injectable
class InviteFriendsBloc extends Bloc<InviteFriendsEvent, InviteFriendsState> {
  final SendEmailUsecase sendEmailUsecase;
  final SendSmsUsecase sendSMSUsecase;
  final GetFriendsUsecase getFriendsUsecase;

  InviteFriendsBloc(
    this.sendEmailUsecase,
    this.sendSMSUsecase,
    this.getFriendsUsecase,
  ) : super(InviteFriendsInitial()) {
    on<GetFriendsEvent>(_onGetFriends);
    on<InviteFriendEvent>(_onInviteFriend);
  }

  Future<void> _onGetFriends(
    GetFriendsEvent event,
    Emitter<InviteFriendsState> emit,
  ) async {
    emit(InviteFriendsLoading());
    await AppUtils.handleCode(
      code: () async {
        final contacts = await getFriendsUsecase.call(
          onPermissionDenied: () => emit(PermissionDenied()),
        );
        emit(InviteFriendsLoaded(invitedContacts: {}, contacts: contacts));
      },
      onNoInternet: (message) {
        emit(InviteFriendsError(message));
      },
      onError: (message) {
        emit(InviteFriendsError(message));
      },
    );
  }

  Future<void> _onInviteFriend(
    InviteFriendEvent event,
    Emitter<InviteFriendsState> emit,
  ) async {
    if (state is InviteFriendsLoaded) {
      final currentState = state as InviteFriendsLoaded;

      await AppUtils.handleCode(
        code: () async {
          switch (event.method) {
            case InviteMethod.sms:
              await sendSMSUsecase(contact: event.contact);
              break;
            case InviteMethod.email:
              await sendEmailUsecase(contact: event.contact);
              break;
          }

          // Update invited contacts
          final updatedInvited = Set<String>.from(currentState.invitedContacts)
            ..add(event.contact.identifier ?? '');

          emit(currentState.copyWith(invitedContacts: updatedInvited));
        },
        onNoInternet: (message) {
          emit(InviteFriendsError(message));
        },
        onError: (message) {
          emit(InviteFriendsError(message));
        },
      );
    }
  }
}
