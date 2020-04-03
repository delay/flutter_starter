String convertToDateAndTime(DateTime date) {
  int year = date.year;
  int month = date.month;
  int day = date.day;
  String _date =
      month.toString() + '/' + day.toString() + '/' + year.toString();
  return _date;
}
