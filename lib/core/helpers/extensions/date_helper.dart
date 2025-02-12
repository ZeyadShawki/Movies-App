
DateTime getDatenowWithoutHours() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

// bool isGlobalDateTimeNowAfterToday() {
//   return globalDatetimenow != getDatenowWithoutHours() ||
//       globalDatetimenow.isAfter(getDatenowWithoutHours());
// }

DateTime stripTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

DateTime getDatenowWithoutMins() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, now.hour);
}

bool isNextDay(DateTime selectedDate, DateTime dueDate) {
  DateTime nextDay = selectedDate.add(Duration(days: 1));

  return dueDate.year == nextDay.year &&
      dueDate.month == nextDay.month &&
      dueDate.day == nextDay.day;
}
