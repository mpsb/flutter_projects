// Object for Event Detail.

class EventDetail {
  String id;
  String _description;
  String _date;
  String _startTime;
  String _endTime;
  String _speaker;
  String _isFavorite;

  EventDetail(this.id, this._description, this._date, this._startTime,
      this._endTime, this._speaker, this._isFavorite);

  String get description => _description;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get speaker => _speaker;
  String get isFavorite => _isFavorite;
}
