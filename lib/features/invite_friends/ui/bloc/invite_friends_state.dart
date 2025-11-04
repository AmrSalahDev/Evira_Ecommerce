part of 'invite_friends_bloc.dart';

sealed class InviteFriendsState extends Equatable {
  const InviteFriendsState();

  @override
  List<Object> get props => [];
}

final class InviteFriendsInitial extends InviteFriendsState {}

final class InviteFriendsLoading extends InviteFriendsState {}

final class InviteFriendsLoaded extends InviteFriendsState {
  final List<Contact> contacts;
  final Set<String> invitedContacts;

  const InviteFriendsLoaded({
    required this.contacts,
    required this.invitedContacts,
  });

  @override
  List<Object> get props => [contacts, invitedContacts];

  InviteFriendsLoaded copyWith({
    List<Contact>? contacts,
    Set<String>? invitedContacts,
  }) {
    return InviteFriendsLoaded(
      contacts: contacts ?? this.contacts,
      invitedContacts: invitedContacts ?? this.invitedContacts,
    );
  }
}

final class InviteFriendsError extends InviteFriendsState {
  final String message;
  const InviteFriendsError(this.message);

  @override
  List<Object> get props => [message];
}

class PermissionDenied extends InviteFriendsState {}
