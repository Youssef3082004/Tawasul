import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/camera_widget.dart';


class Camera extends StatefulWidget{

  const Camera({super.key});

  @override
  State<Camera> createState() => _Home();

} 


class _Home extends State<Camera>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    AppBar page_appbar = AppBar(title: Text("Camera"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),);

    //! ==================================================================== Statisticss class Widget =============================================
    StatisticssWidget class_Stats = StatisticssWidget(key: statisticsKey);

    //! ==================================================================== Camera Container =============================================
    Column camera_controls = Column(children: [Icon(Icons.camera_alt_outlined,size: 50,color: Colors.white),Text("Upload Image or take photo",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18),)],mainAxisAlignment: MainAxisAlignment.start,spacing: 0);
    BoxDecoration widget_decor = BoxDecoration(border: Border.all(color: cons.Container_borderColor,width: 3),color: cons.Container_fillColor,borderRadius: BorderRadius.circular(12));
    Container camera_container =  Container(child: camera_controls,padding: EdgeInsets.all(50),decoration: widget_decor,width: cons.screen_width,);
    InkWell camera_Button =  InkWell(child: camera_container,onTap:()=> statisticsKey.currentState?.showPickerDialog(context) );

    //! ==================================================================== Analyze Button =============================================
    FilledButton analyze_button = FilledButton(onPressed: () => statisticsKey.currentState?.AnalyzeFunction(), child: Text("Analyze",style: TextStyle(fontWeight: FontWeight.w700),),style: cons.Button_style);

    //! ==================================================================== Controls ===================================================
    Column controls = Column(children: [camera_Button,SizedBox(child: analyze_button, width: cons.screen_width - 30,),class_Stats],mainAxisAlignment: MainAxisAlignment.start,spacing: 20,);
    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer());

  }

 


  




}