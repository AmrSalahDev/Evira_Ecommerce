import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';
import 'package:evira_e_commerce/features/customer_service/domain/repo/customer_service_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMessagesUsecase {
  final CustomerServiceRepo _customerServiceRepo;
  GetMessagesUsecase(this._customerServiceRepo);
  Stream<List<MessageEntity>> call() => _customerServiceRepo.getMessages();
}
