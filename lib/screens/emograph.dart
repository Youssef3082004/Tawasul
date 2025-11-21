import "package:flutter/material.dart";
import 'package:tawasul/constants.dart';
import 'package:tawasul/database.dart';
import 'package:tawasul/widget/GraphWidget/GraphLogic.dart';
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

  final dbHelper = DatabaseHelper();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final emotions = {"Love": 5.0,"Happy": 4.5,"Surprise": 3.0,"Sadness": 2.0,"Fear": 1.5,"Anger": 1.0};
  Map<String, List<String>> Emotionsmap = {};
  Map<String, double> dailyScores = {};
  List<String> days = [];


  @override
  void initState() {
    super.initState();
    fetchGroupedEmotions();
  }



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
    List<FlSpot> data =  [
      FlSpot(-0.9, 0),
      FlSpot(0, (days.isNotEmpty ? dailyScores[days[5]] ?? 0.0 : 0.0)),
      FlSpot(2, (days.isNotEmpty ? dailyScores[days[4]] ?? 0.0 : 0.0)),
      FlSpot(4, (days.isNotEmpty ? dailyScores[days[3]] ?? 0.0 : 0.0)),
      FlSpot(6, (days.isNotEmpty ? dailyScores[days[2]] ?? 0.0 : 0.0)),
      FlSpot(8, (days.isNotEmpty ? dailyScores[days[1]] ?? 0.0 : 0.0)),
      FlSpot(10,(days.isNotEmpty ? dailyScores[days[0]] ?? 0.0 : 0.0)),
      FlSpot(11, 0)
    ];

    LineChartBarData plot1 = Plot.PlotShape(data: data, iscurved: true, ShowDots: false);
    LineChartGraph graph =  LineChartGraph(plots: [plot1]);

    Map<String, double> sortedscores = Graphlogic.getSortedEmotionPercentages(Graphlogic.getOverallEmotionPercentages(Emotionsmap,emotions));
    //! ==================================================================== Plot Continaer =============================================
    BoxDecoration graphContainerDecor = BoxDecoration(color: cons.Container_fillColor,borderRadius: BorderRadius.circular(15));
    EmotionBreakdown stats = EmotionBreakdown(scores: sortedscores);
    Column graphcontrols = Column(children: [Texts,graph,Divider(color: cons.Container_borderColor,thickness: 3,),stats],crossAxisAlignment: CrossAxisAlignment.start,spacing: 10,);
    Container graphContainer = Container(child: graphcontrols,width: cons.screen_width,padding: EdgeInsets.all(10),decoration: graphContainerDecor,);

    //! ==================================================================== Key insights =============================================
    Text snapshot = Text("Key Insights",style: TextStyle(color:Colors.white,fontSize: 20,fontFamily: "inter",fontWeight: FontWeight.w600));

    EmotionSnapshot emo1 = EmotionSnapshot(TitleText:sortedscores[sortedscores.keys.toList()[0]] == 0.0? "Un Known": sortedscores.keys.toList()[0],SubtitleText: "Most Frequesnt",IconName: Icons.arrow_upward,IconColor: Colors.green,);
    EmotionSnapshot emo2 = EmotionSnapshot(TitleText: sortedscores[sortedscores.keys.toList()[1]] == 0.0? "Un Known": sortedscores.keys.toList()[1],SubtitleText: "Middle Frequesnt",IconName: Icons.horizontal_rule,IconColor: Colors.amber,);
    EmotionSnapshot emo3 = EmotionSnapshot(TitleText: sortedscores[sortedscores.keys.toList()[3]] == 0.0? "Un Known": sortedscores.keys.toList()[3],SubtitleText: "Least Frequesnt",IconName: Icons.arrow_downward,IconColor: Colors.red,);

    Row snaphots = Row(children: [emo1 ,emo2,emo3],spacing: 10,);
    SingleChildScrollView scrollSnapshot = SingleChildScrollView(child: snaphots,scrollDirection: Axis.horizontal);
    //! ==================================================================== Controls ===================================================
    Column controls = Column(children: [graphContainer,snapshot,SizedBox(child: scrollSnapshot,width: cons.screen_width)],crossAxisAlignment: CrossAxisAlignment.start,spacing: 25,);
    Container main_app = Container(child: SingleChildScrollView(child: controls),padding: EdgeInsets.only(left: 5,right: 5));
    return Scaffold(key: _scaffoldKey,body: main_app,appBar: page_appbar,backgroundColor: cons.main_color,drawer: AppDrawer());

  }


  void fetchGroupedEmotions() async {
    List<String> dates = Graphlogic.getLastFiveDays();
    Map<String, List<String>> emotionsByDate = await DatabaseHelper().getEmotionsGroupedByDate(dates);
    
    setState(() {
      Emotionsmap = emotionsByDate;
      dailyScores = Graphlogic.calculateDailyScores(emotionsByDate, emotions) ;
      days = dates;
    });
    

    print(Emotionsmap);
    print(dailyScores);
    print(days);

  }


  


  




}