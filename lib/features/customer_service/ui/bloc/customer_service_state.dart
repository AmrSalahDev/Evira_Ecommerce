part of 'customer_service_bloc.dart';

sealed class CustomerServiceState extends Equatable {
  const CustomerServiceState();

  @override
  List<Object> get props => [];
}

final class CustomerServiceInitial extends CustomerServiceState {}

final class ChatLoadingState extends CustomerServiceState {}

final class ChatLoadedState extends CustomerServiceState {
  final List<MessageEntity> messages;
  const ChatLoadedState({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class ChatErrorState extends CustomerServiceState {
  final String message;
  const ChatErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
