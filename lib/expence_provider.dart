import 'dart:convert';
import 'dart:io';
import 'package:formflutter/const.dart';
import 'package:formflutter/expencemodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  List<ExpenseModel> _expense = [];

  List<ExpenseModel> get expense {
    return [..._expense];
  }

  ExpenseModel findById(int id) {
    print('id===${id}');
    return expense.firstWhere((expense) => expense.id == id);
  }

  Future<void> fetchAndSetExpense() async {
    final url = Uri.parse('${Constants.hostName}/expenses');
    List<ExpenseModel> loadedExpenses = [];
    try {
      final response = await http.get(url);

      print('status code :  ${response.statusCode}');
      var body = jsonDecode(response.body);
      print(jsonDecode(response.body));
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((esxpenseData) {
        loadedExpenses.add(ExpenseModel(
          id: esxpenseData['Id'],
          title: esxpenseData['Title'],
          type: esxpenseData['Type'],
          date: DateTime.parse(esxpenseData['Date']),
          rate: esxpenseData['Rate'],
        ));
      });
      _expense = loadedExpenses;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addActivity(BuildContext context, ExpenseModel expense) async {
    final url = Uri.parse(Constants.hostName + '/activity');

    try {
      final response = await http.post(url,
          // headers: BearerToken().hearders(context),
          body: json.encode({
            'Title': expense.title,
            'Type': expense.type,
            'Date': '${expense.date!.toIso8601String()}Z',
            'Rate': expense.rate,
          }));

      print("expenses........${json.decode(response.body)}");
      final newActivity = ExpenseModel(
        title: expense.title,
        type: expense.type,
        date: DateTime.parse(expense.date!.toIso8601String()),
        rate: expense.rate,
        id: expense.id,
      );
      _expense.add(newActivity);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Future<void> updateActivity(
  //     BuildContext context, int id, ExpenseProvider newActivity) async {
  //   final activityIndex =
  //       _activity.indexWhere((activities) => activities.id == id);
  //   print(_activity);
  //   print("activity index      .....$activityIndex");
  //   print(activity[1].id);
  //   if (activityIndex >= 0) {
  //     final url = Uri.parse(Constants.hostName + '/activity/$id');
  //     await http.patch(
  //       url,
  //       // headers: BearerToken().hearders(context),
  //       body: json.encode(
  //         {
  //           'Type': newActivity.type,
  //           'Details': newActivity.details,
  //           'Date': newActivity.date!.toIso8601String() + ("Z"),
  //           'Lead': newActivity.lead,
  //         },
  //       ),
  //     );
  //     _activity[activityIndex] = newActivity;
  //     notifyListeners();
  //   } else {
  //     print("update activity error");
  //     print(activityIndex);
  //   }
  //   notifyListeners();
  // }

  // Future<void> deleteActivity(BuildContext context, int id) async {
  //   final url = Uri.parse(Constants.hostName + '/activity/$id');
  //   final existingActivityIndex =
  //       _activity.indexWhere((activities) => activities.id == id);
  //   ExpenseProvider? existingActivity = _activity[existingActivityIndex];
  //   _activity.removeAt(existingActivityIndex);
  //   notifyListeners();
  //   final response = await http.delete(
  //     url,
  //     // headers: BearerToken().hearders(context),
  //   );
  //   if (response.statusCode >= 400) {
  //     _activity.insert(existingActivityIndex, existingActivity);
  //     notifyListeners();
  //     throw HttpException('Could not delete product.');
  //   }
  //   existingActivity = null;
  // }
}
