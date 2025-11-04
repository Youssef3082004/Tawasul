import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:tawasul/constants.dart';


class LineChartGraph extends StatefulWidget {

  final List<LineChartBarData> plots;
  const LineChartGraph({super.key,required this.plots});

  @override
  State<LineChartGraph> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartGraph> {

  @override
  Widget build(BuildContext context) {
    // Constants cons = Constants(context: context);

    AspectRatio graphRatio = AspectRatio(aspectRatio: 1.8,child: Padding(padding: const EdgeInsets.all(25),child: LineChart(mainData())));
    // AspectRatio graphRatio = AspectRatio(aspectRatio: 1.7,child: Padding(padding: const EdgeInsets.all(20),child: LineChart(mainData())));

    return Stack(children: <Widget>[Center(child: graphRatio)]);

  }





  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:Colors.grey);
    String text = switch (value.toInt()) {
      0 => "Day 1",
      2 => 'Day 1',
      4 => 'Day 3',
      6 => 'Day 5',
      8 => 'Day 7',
      10 => 'Day 9',

      _ => '',
    };
    return SideTitleWidget(meta: meta,child: Text(text, style: style),space: 0,);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold,fontSize: 15);
    String text = switch (value.toInt()) {
      1 => '10K',
      3 => '30k',
      4 => '40k',
      5 => '50k',
      _ => '',
    };

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {

    AxisTitles RightTitleDecor =  AxisTitles(sideTitles: SideTitles(showTitles: false),);
    AxisTitles LeftTitleDecor = AxisTitles(sideTitles: SideTitles(showTitles: false,interval: 1,getTitlesWidget: leftTitleWidgets,reservedSize: 42,),);
    AxisTitles Bottomdecor =  AxisTitles(sideTitles: SideTitles(showTitles: true,reservedSize: 30,interval: 1,getTitlesWidget: bottomTitleWidgets,maxIncluded: true));
    AxisTitles TopTitleDecor = AxisTitles(sideTitles: SideTitles(showTitles: false));
    FlTitlesData titledecor = FlTitlesData(show: true,rightTitles: RightTitleDecor,topTitles: TopTitleDecor ,bottomTitles: Bottomdecor,leftTitles: LeftTitleDecor);

    FlGridData griddecor = FlGridData(show: false);

    FlBorderData GraphBorder = FlBorderData(show: false,border: Border.all(color: const Color(0xff37434d)),);

    return LineChartData(gridData: griddecor,titlesData: titledecor,borderData: GraphBorder,minX: 0,maxX: 10,minY: 0,maxY: 5,lineBarsData: widget.plots);
  }



  





}