import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';

abstract class CustomerServiceRepo {
  Future<void> sendMessage({
    required String message,
    required bool isUserMessage,
  });
  Stream<List<MessageEntity>> getMessages();
}
