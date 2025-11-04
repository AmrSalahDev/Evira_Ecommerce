import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/repo/invite_friends_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

@LazySingleton(as: InviteFriendsRepo)
class InviteFriendsRepoImpl implements InviteFriendsRepo {
  String _inviteMessage = "";
  final String _appName = "Evira E-Commerce";
  final String _appUrl = "https://yourapp.com/download";

  InviteFriendsRepoImpl() {
    _inviteMessage =
        "Hey! Check out this amazing app $_appName. Download it here: $_appUrl";
  }

  @override
  Future<void> sendEmail({required Contact contact}) async {
    final emails = contact.emails?.map((e) => e.value).toList();
    if (emails == null || emails.isEmpty) {
      throw Exception('No email found');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emails.first,
      query: 'subject=Check out $_appName&body=$_inviteMessage',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw Exception('Could not launch email app');
    }
  }

  @override
  Future<void> sendSms({required Contact contact}) async {
    final phones = contact.phones
        ?.map((p) => p.value)
        .where((value) => value != null)
        .cast<String>()
        .toList();

    if (phones == null || phones.isEmpty) {
      throw Exception('No phone number found');
    }

    // Use url_launcher to open SMS app
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phones.first,
      queryParameters: {'body': _inviteMessage},
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw Exception('Could not launch SMS app');
    }
  }

  @override
  Future<List<Contact>> getContacts({
    required Function() onPermissionDenied,
  }) async {
    // Request contacts permission
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      status = await Permission.contacts.request();
      if (!status.isGranted) {
        onPermissionDenied();
        return [];
      }
    }

    // Fetch contacts
    Iterable<Contact> contacts = await ContactsService.getContacts(
      withThumbnails: true,
      photoHighResolution: false,
    );

    // Filter contacts without phone number
    contacts = contacts.where(
      (contact) => contact.phones != null && contact.phones!.isNotEmpty,
    );

    return contacts.toList();
  }
}
