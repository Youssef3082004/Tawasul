import 'package:flutter/material.dart';


class Customwidgets {



  static void showCustomSnackBar({required BuildContext context,required String message,bool isError = false}) {

    Text SnackbarText = Text(message,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontFamily: "inter", fontSize: 16),);

    Icon SnackbarIcon = Icon(isError ? Icons.error_outline : Icons.check_circle_outline,color: isError ? Colors.redAccent[200] : Colors.greenAccent[400],);
    Row SnackbarContent = Row(children: [SnackbarIcon,Expanded(child: SnackbarText)],mainAxisAlignment: MainAxisAlignment.center,spacing: 12,);

    final snackBar = SnackBar(content: SnackbarContent,backgroundColor: Color(0xff151c22).withValues(alpha: 0.85),behavior: SnackBarBehavior.floating,elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0),),
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      duration: const Duration(seconds: 3)
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}



class Emotionbox extends StatelessWidget{

  final String ForeText;
  final Color ForeColor;
  const Emotionbox({super.key, required this.ForeText, required this.ForeColor});


  @override
  Widget build(BuildContext context) {
    Text emotion = Text(ForeText,style: TextStyle(color: ForeColor,fontWeight: FontWeight.w700,fontFamily: "inter"),);
    BoxDecoration widget_decor = BoxDecoration(color: ForeColor.withValues(alpha: 0.25),borderRadius: BorderRadius.circular(15));
    return Container(child: Center(child: emotion),width: emotion.data!.length * 12,decoration:widget_decor,height: 25);
    
  }

} 



class Identity  extends StatelessWidget{
  const Identity({super.key});

  @override
  Widget build(BuildContext context) {

    Image Logo_image = Image.asset("assets/images/logo.png",fit: BoxFit.cover,);
    SizedBox image_container = SizedBox(child: Logo_image,width: 200,);
    Text Appliation_name = Text("Tawasul",style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: "Pac"));
    Column IdentityColumn =  Column(children: [image_container,Appliation_name],spacing: 0,crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,);
    return IdentityColumn;
  }
}


