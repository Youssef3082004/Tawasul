import 'package:flutter/material.dart';




class Constants {

  final BuildContext context;
  Constants({required this.context});

  double get screen_width => MediaQuery.of(context).size.width;
  double get screen_height => MediaQuery.of(context).size.height;

  TextTheme get text => TextTheme.of(context);


  Color get main_color => Color(0xff101922);

  Color get Container_borderColor => Color(0xff334155);
  Color get Container_fillColor => Color(0xff15222e);
  Color get SecondColor => Color(0xff137FEC);



  BoxDecoration get Container_decor =>  BoxDecoration(border: Border.all(color: Color(0xff334155),width: 3),color: Color(0xff15222e),borderRadius: BorderRadius.circular(12));
   



  ButtonStyle get Button_style =>  ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xff137FEC)),shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),);




}



class Identity extends StatelessWidget{

  const Identity({super.key});

  @override
  Widget build(BuildContext context) {
    Image Logo_image = Image.asset("assets/images/logo.png",fit: BoxFit.cover,);
    SizedBox image_container = SizedBox(child: Logo_image,width: 200,);
    Text Appliation_name = Text("Tawasul",style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: "Pac"));
    return Column(children: [image_container,Appliation_name],spacing: 0,);
  }

}