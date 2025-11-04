import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/repo/invite_friends_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFriendsUsecase {
  final InviteFriendsRepo inviteFriendsRepo;

  GetFriendsUsecase({required this.inviteFriendsRepo});

  Future<List<Contact>> call({required void Function() onPermissionDenied}) =>
      inviteFriendsRepo.getContacts(onPermissionDenied: onPermissionDenied);
}
