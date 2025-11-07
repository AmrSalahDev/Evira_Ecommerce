import 'dart:async';

import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/customer_service/domain/usecases/get_messages_usecase.dart';
import 'package:evira_e_commerce/features/customer_service/domain/usecases/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';
import 'package:injectable/injectable.dart';

part 'customer_service_event.dart';
part 'customer_service_state.dart';

@injectable
class CustomerServiceBloc
    extends Bloc<CustomerServiceEvent, CustomerServiceState> {
  final GetMessagesUsecase _getMessagesUsecase;
  final SendMessageUsecase _sendMessageUsecase;

  StreamSubscription<List<MessageEntity>>? _messageSubscription;

  CustomerServiceBloc(this._getMessagesUsecase, this._sendMessageUsecase)
    : super(CustomerServiceInitial()) {
    on<GetMessagesEvent>(_onGetMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<MessagesUpdatedEvent>(_onMessagesUpdated);
  }

  // Handler to start the subscription
  Future<void> _onGetMessages(
    GetMessagesEvent event,
    Emitter<CustomerServiceState> emit,
  ) async {
    await AppUtils.handleCode(
      code: () async {
        await _messageSubscription?.cancel();
        emit(ChatLoadingState());

        // Use .listen() to get the subscription object
        _messageSubscription = _getMessagesUsecase().listen(
          (messages) {
            final sortedMessages = List<MessageEntity>.from(messages)
              ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

            // When the stream emits data, add a NEW event
            // Do NOT call emit here.
            add(MessagesUpdatedEvent(sortedMessages));

            if (messages.isEmpty) {
              _sendWelcomeMessages();
            }
          },
          onError: (error) {
            // Handle stream errors by emitting an error state
            emit(ChatErrorState(message: error.toString()));
          },
        );
      },
      onNoInternet: (message) => emit(ChatErrorState(message: message)),
      onError: (message) => emit(ChatErrorState(message: message)),
    );
  }

  // NEW handler for the new event
  Future<void> _onMessagesUpdated(
    MessagesUpdatedEvent event,
    Emitter<CustomerServiceState> emit,
  ) {
    // This handler's only job is to emit the state with the new messages.
    // It's simple, safe, and correct.
    emit(ChatLoadedState(messages: event.messages));
    // No need to return a Future here if there's no async work
    return Future.value();
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<CustomerServiceState> emit,
  ) async {
    final currentState = state;

    if (currentState is ChatLoadedState) {
      await AppUtils.handleCode(
        code: () async {
          final tempMessage = MessageEntity(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: event.message,
            createdAt: DateTime.now(),
            isUserMessage: true,
          );
          // Optimistically update the UI
          emit(
            ChatLoadedState(messages: [...currentState.messages, tempMessage]),
          );
          // Send the message. The stream listener will eventually get the
          // "official" message back from the server and update the state again.
          await _sendMessageUsecase(
            message: event.message,
            isUserMessage: true,
          );
        },
        onNoInternet: (message) {
          emit(ChatErrorState(message: message));
        },
        onError: (message) {
          emit(ChatErrorState(message: message));
        },
      );
    }
  }

  Future<void> _sendWelcomeMessages() async {
    final welcomeMessages = [
      'Hello, good morning',
      'I am a Customer Service. is there anything I can help you with?',
    ];

    for (final messageContent in welcomeMessages) {
      await _sendMessageUsecase(isUserMessage: false, message: messageContent);
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
