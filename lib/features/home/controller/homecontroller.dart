import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapp/features/home/model/weatherresponse.dart';
import 'package:weatherapp/features/home/network/api.dart';
import 'package:weatherapp/features/home/repository/weatherrepository.dart';
import 'package:weatherapp/features/shared/constant/keyvalues.dart';

import '../model/currentdateandtime.dart';
import '../model/relateddatamodel.dart';
final homecontroller=Get.put(Homecontroller());

class Homecontroller extends GetxController{
  RxString dayname=''.obs;
  RxString time=''.obs;
  RxString timetype=''.obs;
  RxString year=''.obs;
  RxString placeName=''.obs;
  RxString daynumber=''.obs;
  RxString monthname=''.obs;
  RxDouble latitude=0.0.obs;
  RxDouble longitude=0.0.obs;
  RxInt weatherstatus=INITIAL.obs;
  RxString weathername=''.obs;
  RxString temperature=''.obs;
  RxString mainname=''.obs;
  final RxBool is_searchbegin = false.obs;
  final RxBool is_itemexist = false.obs;
  final RxBool is_noresult = false.obs;
  final textcontroller=TextEditingController();


  RxList<Relateddatamodel> datamodel=<Relateddatamodel>[].obs;


  final repository=Weatherrepository();


  @override
  void onInit() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      gettimedata();
    });

    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    if (await Permission.location.request().isGranted) {

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );


      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // '${place.locality}, ${place.administrativeArea}, ${place.country}';
        placeName.value= '${place.locality}';

        latitude.value=position.latitude;
        longitude.value=position.longitude;

        fetchweatherreport(
            latitude: homecontroller.latitude.value,
            longitude: homecontroller.longitude.value,
            place: ''
        );




      } else {
        placeName.value='Unknown location';
      }
    } else {
      placeName.value='Location permission denied';
    }
  }

  void gettimedata(){
    dayname.value=_getcurrenttimeanddate()?.dayName??'';
    time.value=_getcurrenttimeanddate()?.time ?? '';

    if(_getcurrenttimeanddate()?.timetype=='AM'){
      timetype.value='am';
    }
    else{
      timetype.value='pm';
    }
    daynumber.value=_getcurrenttimeanddate()?.daynumber??'';
    monthname.value=_getcurrenttimeanddate()?.monthName??'';
    year.value=_getcurrenttimeanddate()?.year ?? '';
    update();
  }


  Currentdateandtime? _getcurrenttimeanddate(){
    final now = DateTime.now();
    final dayName = DateFormat('EEEE').format(now);
    final daynumber=DateFormat('dd').format(now);
    final monthname=DateFormat('MMMM').format(now);
    final timeformat = DateFormat('h:mm a').format(now);
    final timeParts = timeformat.split(' ');
    final time = timeParts[0];
    final amPm = timeParts[1];
    final year = DateFormat('y').format(now);
    update();
    return Currentdateandtime(
        dayName: dayName,
        time: time,
        timetype: amPm,
        daynumber: daynumber,
        monthName: monthname,
        year: year
    );

  }

  Future<void> fetchweatherreport(
  {double? latitude,
    double? longitude,
    String? place
  }
      ) async {
       weatherstatus.value=LOADING;
       update();
       final data  =await repository.getweather(latitude: latitude,longitude:longitude,place: place);
       if(data !=null){
         weatherstatus.value=SUCCESS;
         weathername.value=data.name ?? '';
         temperature.value='${kelvinToCelsius(data.main?.temp)?.toStringAsFixed(2)}°C';
         mainname.value=data.weather?[0].main??'';

        addmodelsdata(data: data);


         update();
       }
       else{
         weatherstatus.value=ERROR;
         update();
       }

  }
  double? kelvinToCelsius(double? kelvin) {
    return (kelvin??0) - 273.15;
  }


  void addmodelsdata({WeatherResponse? data}){
    datamodel.clear();

    datamodel.add(
      Relateddatamodel(
          title: 'Wind',
          value: '${data?.wind?.speed}Km/hr',
          icon: Icons.wind_power,
          iconcolor: Colors.white
      ),

    );
    datamodel.add(
      Relateddatamodel(
          title: 'Max',
          value: '${kelvinToCelsius(data?.main?.tempMax)?.toStringAsFixed(2)}°C',
          icon: Icons.sunny,
          iconcolor: Colors.white
      ),
    );
    datamodel.add(
      Relateddatamodel(
          title: 'Min',
          value: '${kelvinToCelsius(data?.main?.tempMin)?.toStringAsFixed(2)}°C',
          icon: Icons.wind_power,
          iconcolor: Colors.white

      ),
    );

    datamodel.add(
      Relateddatamodel(
          title: 'humidity',
          value: '${data?.main?.humidity}%',
          icon: Icons.water_drop,
          iconcolor: Colors.amber
      ),
    );
    datamodel.add(
      Relateddatamodel(
          title: 'Pressure',
          value: '${data?.main?.pressure}hPa',
          icon: Icons.air,
          iconcolor: Colors.amber
      ),
    );

    datamodel.add(
      Relateddatamodel(
          title: 'Sea-Level',
          value: '${data?.main?.seaLevel}m',
          icon: Icons.leaderboard,
          iconcolor: Colors.amber
      ),
    );



  }



}