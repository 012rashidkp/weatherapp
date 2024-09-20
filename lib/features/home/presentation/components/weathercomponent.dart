
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/features/home/controller/homecontroller.dart';
import 'package:weatherapp/features/shared/resources/colors.dart';

import '../../../shared/components/textcomponent.dart';

class Weathercomponent extends StatelessWidget {
  const Weathercomponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tealcolor,
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 2/2
          ),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          physics: NeverScrollableScrollPhysics(),
          itemCount: homecontroller.datamodel.length,
          itemBuilder: (context,index){
           final datas=homecontroller.datamodel[index];

           return Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
             children: [
               Icon(
                   datas.icon,
                   color: datas.iconcolor,
               ),
               SizedBox(
                 height: 3.0,
               ),
               Textcomponent(
                 text: datas.value,
                 fontsize: 15.0,
                 fontWeight: FontWeight.w600,
                 color: white,
               ),
               SizedBox(
                 height: 3.0,
               ),
               Textcomponent(
                 text: datas.title,
                 fontsize: 15.0,
                 fontWeight: FontWeight.w400,
                 color: white,
               ),

             ],
           );


          }
      ),
    );
  }
}
