import 'package:flutter/material.dart';




class Identity extends StatelessWidget{

  const Identity({super.key});

  @override
  Widget build(BuildContext context) {
    Image Logo_image = Image.asset("assets/images/logo.png",fit: BoxFit.cover,);
    SizedBox image_container = SizedBox(child: Logo_image,width: 200,);
    Text Appliation_name = Text("Tawasul",style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: "Pac"));
    return Column(children: [image_container,Appliation_name],spacing: 0,);
  }

}