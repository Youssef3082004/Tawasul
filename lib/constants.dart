import 'package:flutter/material.dart';




class Constants {

  final BuildContext context;
  Constants({required this.context});

  double get screen_width => MediaQuery.of(context).size.width;
  double get screen_height => MediaQuery.of(context).size.height;

  TextTheme get text => TextTheme.of(context);


  Color get main_color => Color(0xff101922);


  ButtonStyle get Button_style =>  ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff137FEC)),shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),);




}