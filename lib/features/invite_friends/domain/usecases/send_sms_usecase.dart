import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/repo/invite_friends_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendSmsUsecase {
  final InviteFriendsRepo inviteFriendsRepo;

  SendSmsUsecase({required this.inviteFriendsRepo});

  Future<void> call({required Contact contact}) =>
      inviteFriendsRepo.sendSms(contact: contact);
}
