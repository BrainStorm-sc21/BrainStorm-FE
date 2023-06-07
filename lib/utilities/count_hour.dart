String countHour(DateTime givenDate) {
  DateTime currentDate = DateTime.now();

  Duration difference = currentDate.difference(givenDate);
  int minutesDifference = difference.inMinutes;
  int hoursDifference = difference.inHours;
  int daysDifference = difference.inDays;

  print('m: $minutesDifference h: $hoursDifference d: $daysDifference');

  if (daysDifference >= 1) {
    return '$daysDifference일 전';
  } else if (hoursDifference >= 1) {
    return '$hoursDifference시간 전';
  } else if (minutesDifference == 0) {
    return '방금 전';
  } else {
    return '$minutesDifference분 전';
  }
}
