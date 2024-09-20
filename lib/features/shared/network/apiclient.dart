

import 'package:dio/dio.dart';

const String base_url = 'https://api.openweathermap.org/data/2.5/';

BaseOptions apiclient = BaseOptions(
    baseUrl: base_url,
    responseType: ResponseType.json,
    contentType: 'application/json',
    connectTimeout: Duration(milliseconds: 9500),
    receiveTimeout: Duration(milliseconds: 9500),
    // ignore: missing_return
    validateStatus: (code) {
      if (code! >= 200) {
        return true;
      } else
        return false;
    });