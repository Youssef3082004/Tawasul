import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';
import 'package:tawasul/widget/GraphWidget/plot.dart';
import 'package:tawasul/widget/enddrawer.dart';
import 'package:tawasul/widget/GraphWidget/Graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tawasul/widget/GraphWidget/EmotionBreakdown.dart';

class Emograph extends StatefulWidget{

  const Emograph({super.key});

  @override
  State<Emograph> createState() => _Home();

} 


class _Home extends State<Emograph>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final emotions = {"Happy": 0.8,"Sad": 0.2,"Angry": 0.5,"Fear": 0.3,"Surprise": 0.7};



  @override
  Widget build(BuildContext context){
    Constants cons = Constants(context: context);

    //! ==================================================================== Appbar =============================================
    AppBar page_appbar = AppBar(title: Text("Emograph"),leading: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () => _scaffoldKey.currentState!.openDrawer()),scrolledUnderElevation: 0);

    //! ==================================================================== Appbar =============================================
    Text title = Text("Your Emotional Trend",style: TextStyle(color:Colors.white,fontSize: 20,fontFamily: "inter",fontWeight: FontWeight.w600));
    Text subtitle = Text("Evalute youe emotions in simple graph",style:TextStyle(color:Colors.white54,fontSize: 13,fontFamily: "inter",fontWeight: FontWeight.w600));

    Column Texts = Column(children: [title,subtitle],crossAxisAlignment: CrossAxisAlignment.start,);

    //! ==================================================================== plots =============================================
    List<FlSpot> data =  [FlSpot(-0.9, 0),FlSpot(0, 5),FlSpot(2, 2),FlSpot(4, 5),FlSpot(6, 3.1),FlSpot(8, 4),FlSpot(10, 3),FlSpot(11, 4)];
    LineChartBarData plot1 = Plot.PlotShape(data: data, iscurved: true, ShowDots: false);
    LineChartGraph graph =  LineChartGraph(plots: [plot1]);

    //! ==================================================================== Plot Continaer =============================================
    BoxDecoration graphContainerDecor = BoxDecoration(color: cons.Container_fillColor,borderRadius: BorderRadius.circular(15));
    Column graphcontrols = Column(children: [Texts,graph,Divider(color: cons.Container_borderColor,thickness: 3,),EmotionBreakdown()],crossAxisAlignment: CrossAxisAlignment.start,spacing: 10,);
    Container graphContainer = Container(child: graphcontrols,width: cons.screen_width,padding: EdgeInsets.all(10),decoration: graphContainerDecor,);

    //! ==================================================================== Key insights =============================================
    Text snapshot = Text("Key Insights",style: TextStyle(color:Colors.white,fontSize: 20,fontFamily: "inter",fontWeight: FontWeight.w600));

    EmotionSnapshot emo1 = EmotionSnapshot(TitleText: "Happy",SubtitleText: "Most Frequesnt",IconName: Icons.sentiment_satisfied_alt,IconColor: Colors.green,);
    EmotionSnapshot emo2 = EmotionSnapshot(TitleText: "Sad",SubtitleText: "Middle Frequesnt",IconName: Icons.sentiment_dissatisfied_outlined,IconColor: Colors.amber,);
    EmotionSnapshot emo3 = EmotionSnapshot(TitleText: "Anger",SubtitleText: "Least Frequesnt",IconName: Icons.sentiment_very_dissatisfied,IconColor: Colors.red,);


    Row snaphots = Row(children: [emo1 ,emo2,emo3],spacing: 10,);
    SingleChildScrollView scrollSnapshot = SingleChildScrollView(child: snaphots,scrollDirection: Axis.horizontal,);
    //! ==================================================================== Controls ===================================================
    Column controls = Column(children: [graphContainer,snapshot,SizedBox(child: scrollSnapshot,width: cons.screen_width)],crossAxisAlignment: CrossAxisAlignment.start,spacing: 25,);
    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer());

  }

 


  




}