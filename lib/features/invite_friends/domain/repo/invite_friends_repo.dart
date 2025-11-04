import 'package:contacts_service_plus/contacts_service_plus.dart';

abstract class InviteFriendsRepo {
  Future<void> sendSms({required Contact contact});
  Future<void> sendEmail({required Contact contact});
  Future<List<Contact>> getContacts({
    required void Function() onPermissionDenied,
  });
}
