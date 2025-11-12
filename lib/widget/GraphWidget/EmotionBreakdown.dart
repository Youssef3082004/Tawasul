import 'package:flutter/material.dart';
import 'package:tawasul/constants.dart';




class EmotionBreakdown extends StatelessWidget {

  final Map<String, double> scores;
  const EmotionBreakdown({super.key,required this.scores});


  @override
  Widget build(BuildContext context) {

    
    Text title = Text("Emotion Breakdown",style: TextStyle(color:Colors.white,fontSize: 20,fontFamily: "inter",fontWeight: FontWeight.w600));

    Widget class1 = ClassPercentage(context: context,Class_text: scores.keys.first,Percentage: scores[scores.keys.first]?? 0.0,loaded: Color(0xff13ec13));
    Widget class2 = ClassPercentage(context: context,Class_text: scores.keys.toList()[1],Percentage: scores[scores.keys.toList()[1]] ?? 0.0);
    Widget class3 = ClassPercentage(context: context,Class_text: scores.keys.toList()[2],Percentage: scores[scores.keys.toList()[2]] ?? 0.0,loaded: Colors.yellow.shade700);
    Widget class4 = ClassPercentage(context: context,Class_text: scores.keys.toList()[3],Percentage: scores[scores.keys.toList()[3]] ?? 0.0,loaded: Colors.red);

    
    
    Column controls = Column(children: [title,class1,class2,class3,class4],spacing: 10,crossAxisAlignment: CrossAxisAlignment.start,);
    return Container(child: controls,);
    
  }

  Widget ClassPercentage({required BuildContext context,required String Class_text,required double Percentage,Color loaded =const Color(0xff157fec)  }){
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


}



class EmotionSnapshot extends StatelessWidget {

  final String TitleText;
  final String SubtitleText;
  final IconData IconName;
  final Color IconColor;
  const EmotionSnapshot({super.key,required this.TitleText, required this.SubtitleText, required this.IconName, required this.IconColor});


  @override
  Widget build(BuildContext context) {

    Constants cons = Constants(context: context);

    Text Title = Text(TitleText,style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w600),);
    Text subtitle = Text(SubtitleText,style:TextStyle(color:Colors.white54,fontSize: 16,fontWeight: FontWeight.w500));
    Column Texts = Column(children: [Title,subtitle],crossAxisAlignment: CrossAxisAlignment.start,);
        
    Column controls = Column(children: [KeyInsightsIcon(),Texts],spacing: 10,crossAxisAlignment: CrossAxisAlignment.start,);
    BoxDecoration graphContainerDecor = BoxDecoration(color: cons.Container_fillColor,borderRadius: BorderRadius.circular(15));
    return Container(child: controls,decoration: graphContainerDecor,padding: EdgeInsets.all(10),height: 140,width: 150,);   
  }

  Widget KeyInsightsIcon(){
    Icon mainIcon = Icon(IconName,color: IconColor,size: 40);
    return Container(child: mainIcon,padding: EdgeInsets.all(8),decoration: BoxDecoration(color: IconColor.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(10)),);
  }

}