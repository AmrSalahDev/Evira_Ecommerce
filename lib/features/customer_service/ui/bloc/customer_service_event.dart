part of 'customer_service_bloc.dart';

sealed class CustomerServiceEvent extends Equatable {
  const CustomerServiceEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends CustomerServiceEvent {}

class SendMessageEvent extends CustomerServiceEvent {
  final String message;
  const SendMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesUpdatedEvent extends CustomerServiceEvent {
  final List<MessageEntity> messages;

  const MessagesUpdatedEvent(this.messages);

  @override
  List<Object> get props => [messages];
}
