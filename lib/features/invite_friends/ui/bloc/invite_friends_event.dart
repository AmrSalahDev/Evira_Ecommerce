part of 'invite_friends_bloc.dart';

sealed class InviteFriendsEvent extends Equatable {
  const InviteFriendsEvent();

  @override
  List<Object> get props => [];
}

class GetFriendsEvent extends InviteFriendsEvent {}

class InviteFriendEvent extends InviteFriendsEvent {
  final Contact contact;
  final InviteMethod method;

  const InviteFriendEvent({required this.contact, required this.method});

  @override
  List<Object> get props => [contact, method];
}
