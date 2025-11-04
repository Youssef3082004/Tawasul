import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


final GlobalKey<_Home> statisticsKey = GlobalKey<_Home>();

class StatisticssWidget extends StatefulWidget{
  const StatisticssWidget({super.key});

  @override
  State<StatisticssWidget> createState() => _Home();
} 


class _Home extends State<StatisticssWidget>{

  File? fileimage;

  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    Text title = Text("Emotion Breakdown",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Row ggg = Row(children: [title],mainAxisAlignment: MainAxisAlignment.start,);

    Widget class1 = ClassPercentage(Class_text: "Happy",Percentage: 0.75,loaded: Color(0xff13ec13));
    Widget class2 = ClassPercentage(Class_text: "Sad",Percentage: 0.35);
    Widget class3 = ClassPercentage(Class_text: "Natural",Percentage: 0.12,loaded: Colors.red);
      


    Column controls = Column(children: [ggg,PredictedClass(Class_text: "Happy"),class1,class2,class3],mainAxisAlignment: MainAxisAlignment.start,spacing: 15,);
    return Container(child: controls,padding: EdgeInsets.all(10),decoration: cons.Container_decor);

  }


  Widget ClassPercentage({required String Class_text,required double Percentage,Color loaded =const Color(0xff157fec)  }){
    Constants cons = Constants(context: context);

    Text subtitle = Text(Class_text,style:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),);
    Container dot = Container(width: 12.0,height: 12, decoration: BoxDecoration(color: loaded,shape: BoxShape.circle ));

    Row class_row = Row(children: [dot,subtitle],spacing: 5,);

    LinearProgressIndicator probability = LinearProgressIndicator(value: Percentage,backgroundColor: Color(0xff334155),color: loaded,borderRadius: BorderRadius.circular(10),);
    Text probability_text = Text("${(Percentage * 100).toInt()} %",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),);
    SizedBox Sized_probability = SizedBox(child: probability,width: cons.screen_width - 200,height: 10,);
    Row probability_row = Row(children: [Sized_probability,probability_text],mainAxisAlignment: MainAxisAlignment.spaceEvenly,spacing: 10,);


    return Row(children: [class_row,probability_row],crossAxisAlignment: CrossAxisAlignment.center,spacing: 5,mainAxisAlignment: MainAxisAlignment.spaceBetween,);
  }



  Widget PredictedClass({required String Class_text}){
    Constants cons = Constants(context: context);

    Text Primaery =  Text("Primary Emotion:",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold));
    Text Class = Text(Class_text,style: TextStyle(color: Color(0xff13ec13),fontWeight: FontWeight.w800));
    Row class_row = Row(children: [Primaery,Class],spacing: 5);

    Text Desc = Text(style: TextStyle(color: Colors.white54,fontWeight: FontWeight.w500),textAlign: TextAlign.left,"Our analysis indicates that the dominant emotion\ndisplayed is happiness. This is often characteriæd\nby smiling. raised cheeks and crinkling around the\neyes.");
    Row Desc_Row  = Row(children: [Desc]);
    
    Column Class_Column = Column(children: [class_row,Desc_Row],spacing: 5);
    return  Container(child: Class_Column,padding: EdgeInsets.all(10),decoration: cons.Container_decor,width: cons.screen_width,);

  }


  void AnalyzeFunction() => setState((){});



  Future<void> _getimage(ImageSource Source) async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: Source);
    if (photo != null){
        setState(() => fileimage = File(photo.path));
      }
    }


    void showPickerDialog(BuildContext context) {
    Constants cons = Constants(context: context);
    ListTile photo = ListTile(leading: const Icon(Icons.camera_alt,color: Color(0xff157fec),),title: Text('Take Photo',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),),onTap:() {Navigator.of(context).pop();_getimage(ImageSource.camera);},);
    ListTile gallery = ListTile(leading: const Icon(Icons.photo_library,color:Color(0xff157fec)),title: Text('Choose from Gallery',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),),onTap: () {Navigator.of(context).pop();_getimage(ImageSource.gallery);});
    Wrap Controls = Wrap(children: [photo,gallery]);
    showModalBottomSheet(backgroundColor: cons.main_color,context: context,builder: (BuildContext context) => SafeArea(child: Controls));
  }

  

  




}