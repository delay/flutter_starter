DateTime convertToDateOnly(DateTime date) {
  int year = date.year;
  int month = date.month;
  int day = date.day;
  return DateTime(year, month, day);
}
