import 'package:flutter/material.dart';




class Constants {

  final BuildContext context;
  Constants({required this.context});

  double get screen_width => MediaQuery.of(context).size.width;
  double get screen_height => MediaQuery.of(context).size.height;

  TextTheme get text => TextTheme.of(context);

  Color get main_color => Color(0xff101922);
  Color get SecondColor => Color(0xff137FEC);


  Color get Container_borderColor => Color(0xff334155);
  Color get Container_fillColor => Color(0xff15222e);



  BoxDecoration get Container_decor =>  BoxDecoration(border: Border.all(color: Color(0xff334155),width: 3),color: Color(0xff15222e),borderRadius: BorderRadius.circular(12));
   



  ButtonStyle get Button_style => ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {return const Color(0xFF9E9E9E); }
      return const Color(0xFF137FEC); 
    },
  ),
  shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),),
);



}



