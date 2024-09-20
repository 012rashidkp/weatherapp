
import 'package:flutter/cupertino.dart';

double? getheight({BuildContext? context}){

  return MediaQuery.of(context!).size.height;

}

double? getwidth({BuildContext? context}){

  return MediaQuery.of(context!).size.width;

}