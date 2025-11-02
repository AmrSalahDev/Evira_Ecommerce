import 'package:evira_e_commerce/features/profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserImageUsecase {
  final ProfileRepo profileRepo;

  GetUserImageUsecase({required this.profileRepo});

  String? call() => profileRepo.getUserImage();
}
