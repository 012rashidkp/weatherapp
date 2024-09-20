

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/features/home/model/weatherresponse.dart';
import 'package:weatherapp/features/home/network/api.dart';

import '../../shared/network/apiclient.dart';

class Weatherservice{

  Dio dio = Dio(apiclient);

  Future<WeatherResponse?> getweather(
  {double? latitude,
    double? longitude,
    String? place
  }
      ) async {
    try {
      Response response=await dio.get(
          fetchweather,
        queryParameters: {
            appid:api_key,
            lat:latitude,
            lon:longitude,
          if(place!=null || place!='') city:place else city:''
        }
      );

      if(response.statusCode==200){
        print('getresponse... ${response.data}');

        return WeatherResponse.fromJson(response.data);

      }
      else if(response.statusCode==500){
        return WeatherResponse.witherr(response.statusMessage);
      }


      else{
        return WeatherResponse.witherr('something went wrong');

      }

    } catch (e) {
      WeatherResponse.witherr(e.toString());
      // If any exception occurs during the API call, throw an exception with the error message.
      throw Exception('An error occurred: $e');
    }
  }




}