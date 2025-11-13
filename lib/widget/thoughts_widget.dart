import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tawasul/constants.dart';
import 'package:tawasul/database.dart';
import 'package:tawasul/provider/ThoughtsProvider.dart';
import 'package:tawasul/widget/CustomWidget.dart';
import 'package:intl/intl.dart';






class ThoughtsTextfeild extends StatefulWidget{

  const ThoughtsTextfeild({super.key});

  @override
  State<ThoughtsTextfeild> createState() => _ThoughtsTextfeild();

}


class _ThoughtsTextfeild extends State<ThoughtsTextfeild>{

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> titlestate = GlobalKey();

  GlobalKey<FormState> textstate = GlobalKey();

  final dbHelper = DatabaseHelper();

  List<bool> Toggle = [false];
  

  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);
    bool FilledTitle = Provider.of<Thoughtsprovider>(context).isFillTitle;
    bool FilledText = Provider.of<Thoughtsprovider>(context).isFillText;
    bool Analyzed = Provider.of<Thoughtsprovider>(context).isAnalyzed;

    
    

    //! ============================================================================ TextFeild Region ===========================================================

    Consumer title_text = Consumer<Thoughtsprovider>(
      builder: (context, provider, child) {
    return Form(key: titlestate,
      child: TextFormField(controller: titleController,validator: (value) => contentTitle(value),onChanged: (value) => Provider.of<Thoughtsprovider>(context,listen: false).ToggleEmptyTitle(value.length >= 3),autovalidateMode: AutovalidateMode.onUserInteraction,cursorColor: Colors.white54,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
      decoration: InputDecoration(fillColor: cons.Container_fillColor,hintText: "Title",hintStyle: TextStyle(color: Colors.white54),enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)) ),),
    );
  },
);


    Consumer content_text = Consumer<Thoughtsprovider>(
      builder: (context, provider, child) {
    return Form(key:textstate,
    child: TextFormField(controller: contentController,validator: (value) => contentText(value!),
    onChanged: (value) {
      Provider.of<Thoughtsprovider>(context,listen: false).ToggleEmptyText(value.length >= 12);
      Provider.of<Thoughtsprovider>(context,listen: false).UpdateNote(value); 
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,cursorColor: Colors.white54,keyboardType: TextInputType.multiline,maxLines: 10,style: TextStyle(color: Colors.white),
      decoration: InputDecoration(enabledBorder: InputBorder.none,focusedBorder:InputBorder.none ,hintText: "Tell me what in your mind ...",hintStyle: TextStyle(color: Colors.white54,fontSize: 18),fillColor: cons.Container_fillColor)),
    );
  },
);



    //! ============================================================================ Toggle Button ===========================================================
    Icon save_icon = Icon(Toggle[0]? Icons.bookmark  : Icons.bookmark_outline,size: 30);
    ToggleButtons Buttons = ToggleButtons(children: [save_icon], isSelected: Toggle,onPressed:Analyzed && FilledTitle && FilledText ? (int index) => changeToggle(index): null,color: Colors.white,selectedColor: Colors.white,fillColor: Colors.transparent,splashColor: Colors.transparent,disabledColor: Colors.grey);
    
    //! ============================================================================ Controls ===========================================================
    Column Note_Container_Controls = Column(children: [title_text,content_text,Row(children: [Buttons])],spacing: 0);
    
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    return Container(child: Note_Container_Controls,decoration: widget_decor,padding: const EdgeInsets.all(5),);

  }





  
    String? contentText(String? value) {
      if (value == null || value.trim().isEmpty) {return "Please enter some text";} 
      else if (value.trim().length < 12) {return "Please enter at least 12 characters";}
      return null; 
    }
  

  String? contentTitle(String? value) {
      if (value == null || value.trim().isEmpty) {return "Please enter any Title";} 
      else if (value.trim().length < 3) {return "Please enter at least 3 characters";}
      return null; 
    }
  


  void changeToggle(int index) async {
    setState(() => Toggle[index] = !Toggle[index]);

    if (Toggle[index] == true && titleController.text.isNotEmpty) {
      await addNote();
      if (!mounted) return;
      Customwidgets.showCustomSnackBar(context: context,message: "Note saved successfully",isError: false);
    } 
    else {

      final lastNoteId = await dbHelper.getLastNoteId();
      await dbHelper.deleteNote(lastNoteId);
      if (!mounted) return;
      Customwidgets.showCustomSnackBar(context: context,message: "Note removed from your list",isError: true);
    }
  }


  Future<void> addNote() async {
    DateTime now = DateTime.now();
    String dateStr = DateFormat('yyyy-MM-dd').format(now);
    String timeStr = DateFormat('hh:mm a').format(now);

    
    final provider = Provider.of<Thoughtsprovider>(context, listen: false);
    await dbHelper.insertNote({'title': titleController.text,'content': contentController.text,"advice": provider.Advice,
      'date': dateStr,'time': timeStr,'contentState': provider.Emotion,
    });
}

  


}





class HomeWidget extends StatefulWidget{
  final String? Emotion;
  final double? ClassPercentage;
  final String? Advice;
  const HomeWidget({super.key,required this.Emotion,required this.ClassPercentage,required this.Advice});

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


   
    LinearProgressIndicator probability = LinearProgressIndicator(value: widget.ClassPercentage?? 0.0,backgroundColor: Color(0xffd9d9d9),color: Color(0xff157fec),borderRadius: BorderRadius.circular(10),);
    Text probability_text = Text(widget.ClassPercentage != null ? "${(widget.ClassPercentage! * 100).toInt()} %": "",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),);
    SizedBox Sized_probability = SizedBox(child: probability,width: cons.screen_width - 100,height: 10,);
    Row probability_row = Row(children: [Sized_probability,probability_text],mainAxisAlignment: MainAxisAlignment.spaceEvenly);


    Text subtitle_2 = Text("Detected Emotions",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 18),);
    Widget emotion =  Emotion_box();
    Column emotions = Column(children: [subtitle_2,Row(children: [emotion],spacing: 10,)],crossAxisAlignment: CrossAxisAlignment.start,spacing: 5,);



    Text advice_label = Text("Advice For You",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Text advice_Text = Text(widget.Advice?? "",textAlign: TextAlign.start,softWrap: true,maxLines: null,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 15),);
    Column Advice_Column = Column(children: [advice_label,advice_Text],crossAxisAlignment: CrossAxisAlignment.start);


    Column controls = Column(children: [ggg,probability_row,emotions,Advice_Column],mainAxisAlignment: MainAxisAlignment.start,spacing: 15,);
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    return Container(child: controls,padding: EdgeInsets.all(10),decoration: widget_decor);
     



    
  }


  Widget Emotion_box(){

    Text emotion = Text(widget.Emotion?? "",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontFamily: "inter"),);

    BoxDecoration widget_decor = BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(15));

    return Container(child: Center(child: emotion),width: emotion.data!.length * 12,decoration:widget_decor,height: 25);
  }


}