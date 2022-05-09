import 'package:flutter/material.dart';

class ExpenseModel with ChangeNotifier {
  int? id;
  String? title;
  String? type;
  DateTime? date;
  double? rate;

  ExpenseModel({
    this.id,
    this.title,
    this.type,
    this.date,
    this.rate,
  });
}
