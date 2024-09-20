

import 'package:flutter/cupertino.dart';

class Textcomponent extends StatelessWidget {
  final String? text;
  final double? fontsize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;




  const Textcomponent({
    this.text,
    this.fontsize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.fontStyle
  });

  @override
  Widget build(BuildContext context) {
    return  Text(
      text??'',
      textAlign: textAlign,
      style:  TextStyle(
          color: color,
          fontSize: fontsize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,

          decoration: TextDecoration.none
      ),

    );
  }
}
