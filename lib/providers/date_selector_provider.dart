import 'package:flutter/material.dart';

class DateSelectorProvider extends ChangeNotifier {
  String? _date = '';
  String? _year = '';
  String? _month = '';
  String? _day = '';
  TextEditingController yc = TextEditingController();
  TextEditingController mc = TextEditingController();
  TextEditingController dc = TextEditingController();
  String? get date => _date;

  String get year => _year!;

  String? get month => _month;

  String? get day => _day;

  void setMyDate(String date) {
    _date = date;
    debugPrint(_date);
    _year = date.substring(0,4);
    yc.text = date.substring(0,4);
    _month = date.substring(5,7);
    mc.text = date.substring(5,7);
    _day = date.substring(8,10);
    dc.text = date.substring(8,10);
    debugPrint(_year);
    notifyListeners();
  }
}