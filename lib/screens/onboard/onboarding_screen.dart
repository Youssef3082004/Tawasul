import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';

class Onboarding_screen extends StatelessWidget {
  final  String Title;
  final  String Subtitle;
  final  String image;
  final  bool button;
  const Onboarding_screen({super.key,required this.Title ,required this.Subtitle, required this.image,this.button = false});

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants(context: context);

    Image Logo_image = Image.asset("assets/images/logo.png",fit: BoxFit.cover,);
    SizedBox image_container = SizedBox(child: Logo_image,width: 200,);
    Text Appliation_name = Text("Tawasul",style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: "Pac"));
    Column title_column = Column(children: [image_container,Appliation_name],spacing: 0,);


    Image page_image = Image.asset(image,fit: BoxFit.cover,);
    SizedBox page_image_container = SizedBox(child: page_image,width: cons.screen_width - 100);

    Text Title_text = Text(Title,textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontFamily: "Inter",fontSize: 30,height: 1),);
    Text subTitle_text = Text(Subtitle,textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontSize: 10,fontFamily: "Inter"),);
    Column Text_column = Column(children: [Title_text,subTitle_text],spacing: 5,);

    FilledButton Start_button = FilledButton(onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/thoughts", (route) => false), child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900),),style: cons.Button_style);



    Column Controls = Column(children: [title_column,page_image_container,Text_column,button? Start_button:SizedBox.shrink()],spacing: 40);    
    Container main_App = Container(color:cons.main_color,child: Controls,width: cons.screen_width,padding: EdgeInsets.only(top: 70),);
    return Scaffold(body: Center(child: main_App));
  }
}