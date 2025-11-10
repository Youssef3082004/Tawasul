import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/CustomWidget.dart';

// {id: 9, title: gggggg, content: ggggggggggg, date: 2025-11-05, time: 04:00 PM, contentState: happy}

class NoteWidget extends StatelessWidget {

  final IconData leadingicon;
  final Color Iconcolor;
  final Map NoteData;
  const NoteWidget({super.key,required this.leadingicon,required this.Iconcolor,required this.NoteData});


  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);
    
    Icon Leading_icon = Icon(leadingicon,color: Iconcolor,size: 30,);
    Text title = Text(NoteData["title"],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis));
    Text sub_Title = Text(NoteData["date"],style: TextStyle(color: Colors.grey),);
    Icon trailing_icon = Icon(Icons.arrow_forward_ios,color: Colors.white,);
    OutlineInputBorder shape = OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(width: 2,color: cons.Container_borderColor));

    SizedBox NotelistTile =  SizedBox(child: ListTile(tileColor: Color(0xff17202f),leading: Leading_icon,trailing: trailing_icon,title: title,subtitle: sub_Title,shape: shape,),width: cons.screen_width -20,height: 75,);
    return InkWell(child: NotelistTile,onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => NoteContent(content: NoteData,IconColor: Iconcolor))),);
  }


}



class NoteContent extends StatelessWidget {

  final Color IconColor;
  final Map content;
  const NoteContent({super.key,  required this.content,required this.IconColor});


  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    AppBar NoteContentAppbar = AppBar(title: Text("Note"),leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: () => Navigator.pop(context)),scrolledUnderElevation: 0);
    
    //! ==================================================================== Title & Time =============================================
    Text title = Text("My Thought in Day",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Text subtitle = Text("${content["date"]} / ${content["time"]}",textAlign: TextAlign.start,style:TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 15),);
    Column Texts = Column(children: [title,subtitle],crossAxisAlignment: CrossAxisAlignment.start);
    Row ggg = Row(children: [Texts],mainAxisAlignment: MainAxisAlignment.start,);

    //! ==================================================================== Controls =============================================
    Column controls = Column(children: [ggg,PredictedClass(context: context, Class_text: content["contentState"])],mainAxisAlignment: MainAxisAlignment.start,spacing: 40,);
    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));    
    return Scaffold(appBar: NoteContentAppbar,backgroundColor: cons.main_color,body: main_app,);
  }


  Widget PredictedClass({required BuildContext context,required String Class_text}){
    Constants cons = Constants(context: context);

    Text title = Text("Note Title: ${content["title"]}",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "Inter_ExtraBold"),);
    Row title_row = Row(children: [title,],spacing: 5);


    Text Primaery =  Text("Primary Emotion:",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold));
    Row class_row = Row(children: [Primaery,Emotionbox(ForeText:content["contentState"] ,ForeColor: IconColor)],spacing: 5);

    Text Desc = Text("${content["content"]}",style: TextStyle(color: Colors.white54,fontWeight: FontWeight.w500,fontSize: 16),maxLines: null,overflow:TextOverflow.visible,softWrap: true,textWidthBasis: TextWidthBasis.parent,textAlign: TextAlign.left);
    Row Desc_Row  = Row(children: [Expanded(child: Desc)],mainAxisAlignment: MainAxisAlignment.start,);
    
    Column Class_Column = Column(children: [title_row,class_row,Desc_Row],spacing: 5);
    return  Container(child: Class_Column,padding: EdgeInsets.all(10),decoration: cons.Container_decor,width: cons.screen_width,);

  }



}