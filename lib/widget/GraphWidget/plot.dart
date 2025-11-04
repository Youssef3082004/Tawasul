import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Plot {

  
  const Plot();
  static const List<Color> gradientColors = [Color(0xff157fec),Colors.grey,];

  // static const List<Color> gradientColors = [Color(0xff07bde1),Color(0xff0b9f7d),];



  static LineChartBarData PlotShape({required List<FlSpot> data,required bool iscurved,required bool ShowDots}){
    BarAreaData AreaUnfercurve = BarAreaData(show: true,gradient: LinearGradient(colors: gradientColors.map((color) => color.withValues(alpha: 0.3)).toList()));
    return LineChartBarData(spots: data,isCurved: iscurved,gradient: LinearGradient(colors: gradientColors,),barWidth: 5,isStrokeCapRound: true,dotData: const FlDotData(show: false),belowBarData: AreaUnfercurve);
  }
}