extension FormatDate on DateTime {
  String formatDate() {
    final int day = this.day;
    final int month = this.month;
    final int year = this.year;
    final String stringDay = day < 10 ? "0$day" : day.toString();
    final String stringMonth = month < 10 ? "0$month" : month.toString();
    return "$stringDay/$stringMonth/$year";
  }
}
