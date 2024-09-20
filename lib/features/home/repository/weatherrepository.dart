

import 'package:weatherapp/features/home/model/weatherresponse.dart';
import 'package:weatherapp/features/home/network/weatherservice.dart';

class Weatherrepository{

  final Weatherservice service = Weatherservice(); // Use GetX's Get.find() to get the ApiService instance.

  Future<WeatherResponse?> getweather({
    double? latitude,
    double? longitude,
    String? place
}) async {
    try {
      final data = await service.getweather(latitude: latitude,longitude: longitude,place: place);
      return data;
    } catch (e) {
      print('myresponse... error');
      throw Exception('Failed to fetch users');
    }
  }



}