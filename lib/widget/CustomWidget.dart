import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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


  static void ShowAwesomeSnackbar({required BuildContext context,required String title,required String message,bool isError = false}){

    AwesomeSnackbarContent AwesomeSnackbar = AwesomeSnackbarContent(title: title,message:message,
    titleTextStyle: TextStyle(fontFamily: "Inter_ExtraBold",fontWeight: FontWeight.w900,fontSize: 18),
    messageTextStyle: TextStyle(fontFamily: "Alex",fontWeight: FontWeight.w700,fontSize: 15),
    contentType: isError? ContentType.failure: ContentType.success,
    inMaterialBanner: true,color:isError?   Colors.redAccent : Color(0xff157fec) ,);

    final snackBar = SnackBar(content: AwesomeSnackbar,behavior: SnackBarBehavior.floating,elevation: 0.0,backgroundColor: Colors.transparent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0),),duration: const Duration(seconds: 3));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  static void ShowAsesomeDialog({required BuildContext context,required String title,required String message,required VoidCallback Function}){
    AwesomeDialog(context: context,
    dialogBackgroundColor: Color(0xff324255),
                    dialogType: DialogType.info,
                    headerAnimationLoop: false,
                    animType: AnimType.leftSlide,
                    showCloseIcon: false,
                    closeIcon: const Icon(Icons.close_fullscreen_outlined),
                    title: title,
                    desc:message,
                    btnCancelOnPress: () {},
                    onDismissCallback: (type) {},
                    btnOkOnPress: Function,
                    btnCancelColor: Color(0xff0098ff),
                    btnOkColor: Colors.redAccent,
                    titleTextStyle: TextStyle(fontFamily: "Inter_ExtraBold",fontWeight: FontWeight.w900,fontSize: 18,color: Colors.white),
                    descTextStyle: TextStyle(fontFamily: "Alex",fontWeight: FontWeight.w700,fontSize: 15,color: Colors.white)
                    ).show();
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
  final String ImagePath;
  final String Description;
  const Identity({super.key,required this.ImagePath,required this.Description});

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants(context: context);

    Image Logo_image = Image.asset(ImagePath,fit: BoxFit.cover,);
    SizedBox image_container = SizedBox(child: Logo_image,width: 200);

    TextStyle DescriptionStyle = TextStyle(fontSize: Description == "Tawasul"? 30:15,color:Description == "Tawasul"?Colors.white:Colors.white70,fontFamily:Description == "Tawasul"? "Pac": "Alex");
    Text Appliation_name = Text(Description,textAlign: TextAlign.center,style: DescriptionStyle);
     
    return Column(children: [image_container,SizedBox(child: Appliation_name,width: cons.screen_width *0.75,)],spacing: 0,crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,);
  }
}




class LoadedCircle extends StatelessWidget{

  final String TextUnderLoad;
  const LoadedCircle({super.key , required this.TextUnderLoad});

  @override
  Widget build(BuildContext context) {
    Constants cons = Constants(context: context);

    Text title = Text(TextUnderLoad,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white70));
    return Column(children: [CircularProgressIndicator(color: cons.SecondColor,), title],mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,spacing: 10,);

  }

}


