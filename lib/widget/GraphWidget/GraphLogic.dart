import 'dart:collection';


class Graphlogic {

  static List<String> getLastFiveDays() {
    DateTime today = DateTime.now();
    List<String> days = [];

    for (int i = 0; i <= 5; i++) {
        DateTime day = today.subtract(Duration(days: i));
        String formattedDate = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
        days.add(formattedDate);
    }

    return days;
  } 


  static Map<String, double> getOverallEmotionPercentages(Map<String, List<String>> emotionsMap, Map<String, double> emotionScores) {
      Map<String, double> totalScores = {};
      double sum = 0.0;

      emotionScores.keys.forEach((emotion) => totalScores[emotion] = 0.0);

      emotionsMap.forEach((date, emotionsList) {
        emotionsList.forEach((emotion) {
          if (totalScores.containsKey(emotion)) {
            totalScores[emotion] = totalScores[emotion]! + emotionScores[emotion]!;
            sum += emotionScores[emotion]!; // track total sum
          }
        });
      });

      if (sum > 0) {totalScores.updateAll((key, value) => value / sum);}

      return totalScores;
    }



   static Map<String, double> calculateDailyScores(Map<String, List<String>> emotionsMap, Map<String, double> emotionsScores) {
    Map<String, double> dailyScores = {};

    emotionsMap.forEach((date, emotionsList) {
      if (emotionsList.isEmpty) {
        dailyScores[date] = 0.0;
      } 
      else {
        double score = emotionsList.map((e) => emotionsScores[e] ?? 0.0).reduce((a, b) => a + b); 
        score = score / emotionsList.length; 
        dailyScores[date] = score;
      }
    });

    return dailyScores;
  }


  static Map<String, double> getSortedEmotionPercentages(Map<String, double> percentages) {
  var sortedEntries = percentages.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  return LinkedHashMap<String, double>.fromEntries(sortedEntries);
  
}


}