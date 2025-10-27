import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';

class Welcome extends StatefulWidget{


  const Welcome({super.key});


  @override
  State<Welcome> createState() => _Welcome();

}


class _Welcome extends State<Welcome>{



  @override
  Widget build(BuildContext context) {
    Constants cons = Constants(context: context);

    //! ==================================================================== Texts Widgets ================================================= 

    Text Title = Text("Understand what you truly feel by",style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: "Inter"),);
    Text Appliation_name = Text("Tawasul",style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: "Pac"));
    Column Text_column = Column(children: [Title,Appliation_name],mainAxisAlignment: MainAxisAlignment.center,spacing:5);

    //! ==================================================================== Texts Widgets ================================================= 
    Text start_text = Text("Start",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "Inter",fontWeight: FontWeight.w800),);
    Text subTitle = Text("Explore\nYourself ",style: TextStyle(fontSize: 35,color: Colors.white,fontFamily: "Inter_ExtraBold",fontWeight: FontWeight.bold,height: 1),);

    
    FilledButton Start_button = FilledButton(onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (route) => false), child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.w900),),style: cons.Button_style);
    Column page_end = Column(children: [start_text,subTitle,SizedBox(child: Start_button,width: cons.screen_width - 100,)],mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,spacing:5);


    Column Controls = Column(children: [Text_column,page_end],spacing: 520,);
    Container main_app = Container(child: Controls,width: cons.screen_width,padding: EdgeInsets.only(top: 100),decoration: BoxDecoration(image:DecorationImage(image: AssetImage('assets/images/welcome.png'),fit: BoxFit.cover))); 
    return Scaffold(body: Center(child: main_app));
  }

}