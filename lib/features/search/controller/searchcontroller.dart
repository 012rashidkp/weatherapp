
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

final searchcontroller=Get.put(Searchcontroller());

class Searchcontroller extends GetxController{

  RxDouble  getlatitude=0.0.obs;
  RxDouble getlongitude=0.0.obs;
 RxString location = "Search Location".obs;
 RxString getlocation=''.obs;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;

  LatLng startLocation = LatLng(11.260220, 75.846090);







}