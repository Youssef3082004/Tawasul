List<String> getLastFiveDays() {
  DateTime today = DateTime.now();
  List<String> days = [];

  for (int i = 0; i <= 5; i++) {
    DateTime day = today.subtract(Duration(days: i));
    String formattedDate = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    days.add(formattedDate);
  }

  return days;
}

void main() {
  List<String> lastDays = getLastFiveDays();
  print(lastDays);
}
