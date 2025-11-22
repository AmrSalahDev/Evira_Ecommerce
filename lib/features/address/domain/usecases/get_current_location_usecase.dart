import 'package:evira_e_commerce/core/utils/location_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentLocationUsecase {
  Future<Position> call() async {
    // Check if location service is enabled
    bool serviceEnabled = await LocationUtils.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await LocationUtils.requestLocationPermission();
    }

    // Get current position
    final position = await LocationUtils.getCurrentPosition();
    return position;
  }
}
