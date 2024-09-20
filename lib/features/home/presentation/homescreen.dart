
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/features/home/controller/homecontroller.dart';
import 'package:weatherapp/features/home/presentation/components/searchfield.dart';
import 'package:weatherapp/features/home/presentation/components/weathercomponent.dart';
import 'package:weatherapp/features/search/controller/searchcontroller.dart';
import 'package:weatherapp/features/shared/constant/keyvalues.dart';
import 'package:weatherapp/features/shared/resources/colors.dart';
import 'package:weatherapp/features/shared/resources/dimens.dart';
import 'package:weatherapp/features/shared/route/routename.dart';

import '../../shared/components/textcomponent.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: getwidth(context: context),
        height: getheight(context: context),
        color: white,
        child: Obx(
          ()=> homecontroller.weatherstatus.value==LOADING
              ?Center(
                child: CircularProgressIndicator(
                            color: tealcolor,
                          ),
              ):
          homecontroller.weatherstatus.value==SUCCESS
          ?SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),

            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 20, // Ensures content takes up the viewport height minus padding
                ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  Searchbutton(
                    initialvalue: searchcontroller.location.value,
                    editingController: homecontroller.textcontroller,
                    hintvalue: 'Search By City',

                    textInputType: TextInputType.text,
                    icon: Icons.search,
                    searchclick: (){
                      context.push(searchroute);
                    },
                    onchange: (query) {
                      if (query.isNotEmpty) {
                        homecontroller.is_searchbegin.value = true;
                        homecontroller.is_itemexist.value = false;
                        Timer(Duration(milliseconds: 500), () {
                          // homecontroller.getsearchresult(query: query);
                          // homecontroller.storemyquery.value = query;
                        });
                      } else {
                        homecontroller.is_searchbegin.value = false;
                        homecontroller.is_itemexist.value = false;
                        homecontroller.is_noresult.value = false;
                      }
                    },
                    // backclick: () {
                    //   Navigator.of(context).pop();
                    //   homecontroller.is_itemexist.value = false;
                    //   homecontroller.is_noresult.value = false;
                    // },
                    clearclick: (editcontroller, focusnode) {
                      editcontroller.clear();
                      focusnode.unfocus();
                      searchcontroller.getlocation.value='';

                      homecontroller.fetchweatherreport(
                          latitude: homecontroller.latitude.value,
                          longitude: homecontroller.longitude.value,
                          place: ''
                      );



                    },
                  ),

                  SizedBox(
                    height: 15,
                  ),


                  Textcomponent(
                    text: homecontroller.weathername.value,
                    fontsize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: tealcolor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Textcomponent(
                    text: homecontroller.temperature.value,
                    fontsize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: tealcolor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Textcomponent(
                    text: homecontroller.mainname.value,
                    fontsize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: tealcolor,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  Textcomponent(
                    text: '${homecontroller.dayname.value} ${homecontroller.daynumber.value} ${homecontroller.monthname.value} ${homecontroller.year.value}',
                    fontsize: 17.0,
                    fontWeight: FontWeight.w500,
                    color: tealcolor,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Textcomponent(
                    text: '${homecontroller.time.value} ${homecontroller.timetype.value}',
                    fontsize: 17.0,
                    fontWeight: FontWeight.w500,
                    color: tealcolor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                      height: 155,
                      width: 155,
                      'assets/icons/cloudy.png'
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Weathercomponent()






                ],


              ),
              )
            ),
          )
          :Container()
        ),






      ),
    );
  }
}
