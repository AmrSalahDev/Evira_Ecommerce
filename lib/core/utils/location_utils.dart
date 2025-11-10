import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class LocationUtils {
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
    );
  }

  static Future<Map<String, String>> getAddressFromLatLng(
    LatLng position,
  ) async {
    try {
      return await _getAddressFromNominatim(position);
    } catch (fallbackError) {
      return _getEmptyAddress();
    }
  }

  static Future<Map<String, String>> _getAddressFromNominatim(
    LatLng position,
  ) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=18&addressdetails=1',
      );

      final response = await http.get(
        url,
        headers: {'User-Agent': 'EviraECommerce/1.0 (contact@example.com)'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['address'] != null) {
          final address = data['address'];
          return {
            'street': address['road'] ?? address['pedestrian'] ?? '',
            'city':
                address['city'] ?? address['town'] ?? address['village'] ?? '',
            'state': address['state'] ?? '',
            'country': address['country'] ?? '',
            'postalCode': address['postcode'] ?? '',
            'subLocality': address['suburb'] ?? address['neighbourhood'] ?? '',
          };
        }
      }

      return _getEmptyAddress();
    } catch (e) {
      return _getEmptyAddress();
    }
  }

  static Map<String, String> _getEmptyAddress() {
    return {
      'street': '',
      'city': '',
      'state': '',
      'country': '',
      'postalCode': '',
      'subLocality': '',
    };
  }
}
