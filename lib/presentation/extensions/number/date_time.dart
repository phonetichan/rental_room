extension DateTimeExtension on DateTime {
  String toAMPMFormat() {
    int hour =
        this.hour > 12 ? this.hour - 12 : (this.hour == 0 ? 12 : this.hour);

    String period = this.hour >= 12 ? 'PM' : 'AM';

    return '$year/${_twoDigits(month)}/${_twoDigits(day)}   '
        '${_twoDigits(hour)}:${_twoDigits(minute)}:${_twoDigits(second)} $period';
  }

  String toDate() {
    return '$year/${_twoDigits(month)}/${_twoDigits(day)}';
  }

  String toTime() {
    int hour =
        this.hour > 12 ? this.hour - 12 : (this.hour == 0 ? 12 : this.hour);

    String period = this.hour >= 12 ? 'PM' : 'AM';

    return '${_twoDigits(hour)}:${_twoDigits(minute)}:${_twoDigits(second)} $period';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
