import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';





class NoteWidget extends StatelessWidget {

  final String Title;
  final String subtitle;
  final IconData leadingicon;
  final Color Iconcolor;


  const NoteWidget({super.key,required this.Title,required this.subtitle,required this.leadingicon,required this.Iconcolor});


  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);
    
    Icon Leading_icon = Icon(leadingicon,color: Iconcolor,size: 30,);
    Text title = Text(Title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis));
    Text sub_Title = Text(subtitle,style: TextStyle(color: Colors.grey),);
    Icon trailing_icon = Icon(Icons.arrow_forward_ios,color: Colors.white,);
    OutlineInputBorder shape= OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(width: 2,color: cons.Container_borderColor));

    return SizedBox(child: ListTile(tileColor: Color(0xff17202f),leading: Leading_icon,trailing: trailing_icon,title: title,subtitle: sub_Title,shape: shape,),width: cons.screen_width -20,height: 75,);
    
  }


}