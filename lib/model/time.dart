class DateTimeRange {
  DateTime from;
  DateTime to;

  DateTimeRange.noEnd(this.from);

  DateTimeRange.noBegin(this.to);

  DateTimeRange(this.from, this.to);
}
