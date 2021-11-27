class IncomeExpenseModel{
  int? _id;
  String? _entryId;
  String? _date;
  String? _amount;
  String? _description;
  String? _status;

  IncomeExpenseModel(this._entryId, this._date, this._amount,this._description, this._status);

  int? get id => _id;
  String get entryId => _entryId!;
  String get date => _date!;
  String get amount => _amount!;
  String get status => _status!;
  String get description => _description!;

  //Convert a note object to mop object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map['id'] = _id;
    }

    map['entryId'] = _entryId;
    map['date'] = _date;
    map['amount'] = _amount;
    map['description'] = _description;
    map['status'] = _status;
    return map;
  }

  //Extract a note object from a map object
  IncomeExpenseModel.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _entryId = map['entryId'];
    _date = map['date'];
    _amount = map['amount'];
    _description = map['description'];
    _status = map['status'];
  }
}