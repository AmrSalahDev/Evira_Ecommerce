import 'package:evira_e_commerce/features/customer_service/data/models/message_model.dart';
import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';

abstract class CustomerServiceRemoteDatasource {
  Future<void> sendMessage({required MessageModel messageModel});
  Stream<List<MessageEntity>> getMessages();
}
