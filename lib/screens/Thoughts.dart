import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/Home_widget.dart';
// import 'package:tawasul/widget/constant_widget.dart';

class Thoughts extends StatefulWidget{

  const Thoughts({super.key});

  @override
  State<Thoughts> createState() => _Home();

} 


class _Home extends State<Thoughts>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    AppBar page_appbar = AppBar(title: Text("Thoughts"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),);

    //! ==================================================================== page Title & Page subtitle =============================================
    Text title = Text("How are you Feeling?",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Text subtitle = Text("write it down",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 15),);
    Column Texts = Column(children: [title,subtitle],crossAxisAlignment: CrossAxisAlignment.start);
    Row ggg = Row(children: [Texts],mainAxisAlignment: MainAxisAlignment.start,);

    //! ==================================================================== Note Widget =============================================
    TextFormField title_text = TextFormField(controller: titleController,cursorColor: const Color(0xff7d7b7d),style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
    decoration: InputDecoration(hintText: "Title",hintStyle: TextStyle(color: Colors.white54),enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)) ),);
    
    TextFormField content_text =  TextFormField(controller: contentController,cursorColor: Color(0xff7d7b7d),keyboardType: TextInputType.multiline,maxLines: 10,style: TextStyle(color: Colors.white),
    decoration: InputDecoration(enabledBorder: InputBorder.none,focusedBorder:InputBorder.none ,hintText: "Tell me what in your mind ..."));

    Column Note_Container_Controls = Column(children: [title_text,content_text],spacing: 0);
    
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    Container Note_container = Container(child: Note_Container_Controls,decoration: widget_decor,padding: const EdgeInsets.all(5),);

    //! ==================================================================== Analyze Button =============================================
    FilledButton analyze_button = FilledButton(onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/onboarding", (route) => false), child: Text("Analyze",style: TextStyle(fontWeight: FontWeight.w700),),style: cons.Button_style);

    //! ==================================================================== Controls ===================================================
    Column controls = Column(children: [ggg,Note_container,SizedBox(child: analyze_button, width: cons.screen_width - 30,),HomeWidget()],mainAxisAlignment: MainAxisAlignment.start,spacing: 20,);
    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer());

  }




  




}