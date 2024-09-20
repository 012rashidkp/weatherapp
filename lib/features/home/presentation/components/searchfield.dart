

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/features/search/controller/searchcontroller.dart';

import '../../../shared/constant/keyvalues.dart';
import '../../../shared/resources/colors.dart';

class Searchbutton extends StatefulWidget {
  final String? hintvalue;
  final String? initialvalue;
  final TextInputType? textInputType;
  final TextEditingController? editingController;
  final IconData? icon;
  final Function(String)? onchange;
  final Function()? backclick;
  final Function()? completed;
  final Function()? submited;
  final Function()? searchclick;

  final Function(TextEditingController, FocusNode)? clearclick;
  const Searchbutton({
    Key? key,
    this.hintvalue,
    this.initialvalue,
    this.textInputType,
    this.editingController,
    this.icon,
    this.onchange,
    this.backclick,
    this.clearclick,
    this.completed,
    this.submited,
    this.searchclick
  }) : super(key: key);

  @override
  _SearchbuttonState createState() => _SearchbuttonState();
}

class _SearchbuttonState extends State<Searchbutton> {
  late  TextEditingController textcontroller=TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    textcontroller=widget.editingController!;

    textcontroller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    // Add any specific actions you want to perform when text changes
  }

  @override
  void dispose() {
    // textcontroller.dispose();
    //     _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mheight = MediaQuery.of(context).size.height;
    return Container(
      height: mheight * 0.065,
      child: TextFormField(
        onTap: (){
       widget.searchclick!();
        },
        textAlign: TextAlign.justify,
        controller: textcontroller,

        readOnly: true,
        style: const TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 17),
        keyboardType: widget.textInputType,
        autofocus: false,
        focusNode: _focusNode,
        onChanged: (value) {
          widget.onchange!(value);
        },
        onEditingComplete: (){
          widget.completed!();

        },
        onFieldSubmitted: (value){
          widget.onchange!(value);

        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: hinttextcolor, width: borderwidth),
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hinttextcolor, width: borderwidth),
            borderRadius: BorderRadius.circular(4.0),
          ),
          filled: true,
          fillColor: white,
          hintText:searchcontroller.getlocation.value==''? widget.hintvalue:searchcontroller.getlocation.value,
          prefixIcon: GestureDetector(
            onTap: () {
              widget.backclick!();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 3),
              child: Icon(
                size: 21,
                widget.icon,
                color: tealcolor,
              ),
            ),
          ),
          prefixIconConstraints: BoxConstraints(minHeight: 16, minWidth: 16),
          suffixIcon: GestureDetector(
            onTap: () {
              widget.clearclick!(textcontroller, _focusNode);
            },
            child: const Icon(
              Icons.close,
              size: 21,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: hinttextcolor, width: borderwidth),
            borderRadius: BorderRadius.circular(4.0),
          ),
          hintStyle: TextStyle(
            color: greybtncolor,
            fontSize: 17,
          ),
          focusColor: bodycolor,
          contentPadding: EdgeInsets.symmetric(vertical: 11),
        ),
      ),
    );
  }
}
