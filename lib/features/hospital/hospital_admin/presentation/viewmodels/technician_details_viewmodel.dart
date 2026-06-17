import 'package:vital_match/core/di/service_locator.dart';
import 'package:vital_match/features/users/domain/entities/app_user.dart';

class TechnicianDetailsViewModel {

  Future<AppUser?> getUser(
    String userId,
  ) async {

    return await ServiceLocator
        .getUserByIdUsecase(
      userId,
    );
  }
}