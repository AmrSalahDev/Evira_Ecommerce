import 'package:evira_e_commerce/features/customer_service/domain/repo/customer_service_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendMessageUsecase {
  final CustomerServiceRepo _customerServiceRepo;

  SendMessageUsecase(this._customerServiceRepo);

  Future<void> call({required String message, required bool isUserMessage}) =>
      _customerServiceRepo.sendMessage(
        message: message,
        isUserMessage: isUserMessage,
      );
}
