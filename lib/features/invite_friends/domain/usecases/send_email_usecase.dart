import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/repo/invite_friends_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendEmailUsecase {
  final InviteFriendsRepo inviteFriendsRepo;

  SendEmailUsecase(this.inviteFriendsRepo);

  Future<void> call({required Contact contact}) =>
      inviteFriendsRepo.sendEmail(contact: contact);
}
