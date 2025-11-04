import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';




class ThoughtsTextfeild extends StatefulWidget{

  const ThoughtsTextfeild({super.key});

  @override
  State<ThoughtsTextfeild> createState() => _ThoughtsTextfeild();

}


class _ThoughtsTextfeild extends State<ThoughtsTextfeild>{

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<bool> Toggle = [false];


  @override
  Widget build(BuildContext context) {

     

    Constants cons = Constants(context: context);

    //! ============================================================================ TextFeild Region ===========================================================
    TextFormField title_text = TextFormField(controller: titleController,cursorColor: Colors.white54,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
    decoration: InputDecoration(fillColor: cons.Container_fillColor,hintText: "Title",hintStyle: TextStyle(color: Colors.white54),enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)) ),);
    
    TextFormField content_text =  TextFormField(controller: contentController,cursorColor: Colors.white54,keyboardType: TextInputType.multiline,maxLines: 10,style: TextStyle(color: Colors.white),
    decoration: InputDecoration(enabledBorder: InputBorder.none,focusedBorder:InputBorder.none ,hintText: "Tell me what in your mind ...",hintStyle: TextStyle(color: Colors.white54,fontSize: 18),fillColor: cons.Container_fillColor));

    //! ============================================================================ Toggle Button ===========================================================
    Icon save_icon = Icon(Toggle[0]? Icons.bookmark  : Icons.bookmark_outline,size: 30);
    ToggleButtons Buttons = ToggleButtons(children: [save_icon], isSelected: Toggle,onPressed: (int index) => changeToggle(index),color: Colors.grey,selectedColor: Colors.white,fillColor: Colors.transparent,splashColor: Colors.transparent);


    //! ============================================================================ Controls ===========================================================
    Column Note_Container_Controls = Column(children: [title_text,content_text,Row(children: [Buttons])],spacing: 0);
    
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    return Container(child: Note_Container_Controls,decoration: widget_decor,padding: const EdgeInsets.all(5),);

  }


  void changeToggle(int index) => setState(() => Toggle[index] = !Toggle[index]);
  


}





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