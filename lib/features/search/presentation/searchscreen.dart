
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:weatherapp/features/search/controller/searchcontroller.dart';
import 'package:weatherapp/features/search/presentation/components/searchitemfield.dart';
import 'package:weatherapp/features/shared/resources/colors.dart';
import 'package:weatherapp/features/shared/resources/dimens.dart';

import '../../home/controller/homecontroller.dart';
import '../../shared/constant/keyvalues.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: getwidth(context: context),
        height: getheight(context: context),
        color: white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Stack(
              children:[

                GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: searchcontroller.startLocation, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created

                  },
                ),



                //search autoconplete input
                Positioned(  //search input bar
                    top:10,
                    child: InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              radius:10000000,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              language: 'in',
                              components: [Component(Component.country, 'in')],
                              //google_map_webservice package
                              onError: (err){

                                print("map error.. $err");
                              }
                          );
                          if(place!=null){
                            searchcontroller.getlocation.value=place.description.toString();
                            searchcontroller.location.value=place.description.toString();
                            final plist = GoogleMapsPlaces(apiKey:googleApikey,
                              apiHeaders: await const GoogleApiHeaders().getHeaders(),
                              //from google_api_headers package
                            );
                            String placeid = place.placeId ?? "0";
                            final detail = await plist.getDetailsByPlaceId(placeid);
                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final long = geometry.location.lng;


                            homecontroller.fetchweatherreport(
                                latitude: lat,
                                longitude: long,
                                place: ''
                            );



                             Navigator.of(context).pop();
                          }

                        },
                        child:Padding(
                          padding: EdgeInsets.all(15),
                          child: Card(
                            child: Container(
                                padding: EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width - 40,
                                child: Obx(
                                      ()=> ListTile(
                                    title:Text(searchcontroller.location.value, style: const TextStyle(fontSize: 18),),
                                    trailing: const Icon(Icons.search),
                                    dense: true,
                                  ),
                                )
                            ),
                          ),
                        )
                    )
                ),



              ]
          ),
        )



      ),

    );
  }
}
