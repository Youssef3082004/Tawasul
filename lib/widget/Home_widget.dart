import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';


class HomeWidget extends StatefulWidget{

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _Home();

} 


class _Home extends State<HomeWidget>{


  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);



    Text title = Text("AI Analysis",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Text subtitle = Text("overall sentimant of the Note",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 15),);
    Column Texts = Column(children: [title,subtitle],crossAxisAlignment: CrossAxisAlignment.start);
    Row ggg = Row(children: [Texts],mainAxisAlignment: MainAxisAlignment.start,);


   
    LinearProgressIndicator probability = LinearProgressIndicator(value: 0.75,backgroundColor: Color(0xffd9d9d9),color: Color(0xff157fec),borderRadius: BorderRadius.circular(10),);
    Text probability_text = Text("75 %",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),);
    SizedBox Sized_probability = SizedBox(child: probability,width: cons.screen_width - 100,height: 10,);
    Row probability_row = Row(children: [Sized_probability,probability_text],mainAxisAlignment: MainAxisAlignment.spaceEvenly);


    Text subtitle_2 = Text("Detected Emotions",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 18),);
    Widget emotion =  Emotion_box();
    Column emotions = Column(children: [subtitle_2,Row(children: [emotion,emotion,emotion],spacing: 10,)],crossAxisAlignment: CrossAxisAlignment.start,spacing: 5,);

    Text advice_label = Text("Advice For You",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Text advice_Text = Text("You can move on by practising sports\n that you love",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 15),);
    Column Advice_Column = Column(children: [advice_label,advice_Text],crossAxisAlignment: CrossAxisAlignment.start);
    Row Advice_row = Row(children: [Advice_Column],mainAxisAlignment: MainAxisAlignment.start,);


    Column controls = Column(children: [ggg,probability_row,emotions,Advice_row],mainAxisAlignment: MainAxisAlignment.start,spacing: 15,);
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    return Container(child: controls,padding: EdgeInsets.all(10),decoration: widget_decor);
     



    
  }


  Widget Emotion_box(){

    Text emotion = Text("Happy",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "inter"),);

    BoxDecoration widget_decor = BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(15));

    return Container(child: Center(child: emotion),width: emotion.data!.length * 12,decoration:widget_decor,height: 25);
  }


  




}