import 'package:flutter/material.dart';
import 'package:formflutter/custom_button.dart';
import 'package:formflutter/custom_text_field.dart';
import 'package:formflutter/expence_provider.dart';
import 'package:formflutter/expencemodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController dateinput = TextEditingController();
  final form = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now();
  final detailsFocusNode = FocusNode();
  final dateFocusNode = FocusNode();

  @override
  void initState() {
    dateinput.text = '';
    super.initState();
  }

  var addedActivity = ExpenseModel(
    id: null,
    title: "",
    type: "",
    date: DateTime.parse("2022-01-22T15:04:05.000Z"),
    rate: 0,
  );
  var _dropDownValue;
  var types = ['Meeting', 'PhoneCall', "E-mail", "Direct Meeting"];
  var inputFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ADD Expense'),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.025),
          ),
        ],
      ),
      body: Form(
        key: form,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Type',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .09,
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01),
                              width: MediaQuery.of(context).size.width * .45,
                              height: MediaQuery.of(context).size.width * .1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.025),
                                  border: Border.all()),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: _dropDownValue == null
                                      ? Text(
                                          'Dropdown',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        )
                                      : Text(
                                          _dropDownValue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                  isExpanded: true,
                                  iconSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: [
                                    'Meeting',
                                    'Phone Call',
                                    'E-mail',
                                    'Direct Meeting'
                                  ].map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _dropDownValue = val;
                                      },
                                    );

                                    addedActivity = ExpenseModel(
                                      id: addedActivity.id,
                                      type: val.toString(),
                                      title: addedActivity.title,
                                      date: addedActivity.date,
                                      rate: addedActivity.rate,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                          icon: const Icon(
                            Icons.list,
                          ),
                          horizontalPadding:
                              MediaQuery.of(context).size.width * 0.06,
                          hintext: 'Details',
                          onSaved: (value) {
                            addedActivity = ExpenseModel(
                              id: addedActivity.id,
                              type: addedActivity.type,
                              title: value,
                              date: addedActivity.date,
                              rate: addedActivity.rate,
                            );
                          },
                          focusNode: detailsFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(dateFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add activity details.';
                            }
                            return null;
                          }),
                      CustomTextField(
                          icon: const Icon(Icons.calendar_today),
                          controller: dateinput,
                          readOnly: true,
                          horizontalPadding:
                              MediaQuery.of(context).size.width * 0.06,
                          hintext: 'Date',
                          keyboardType: TextInputType.datetime,
                          onTap: () => _selectDate(context),
                          onSaved: (value) {
                            addedActivity = ExpenseModel(
                              id: addedActivity.id,
                              type: addedActivity.type,
                              title: addedActivity.title,
                              date: DateTime.parse(value!),
                              rate: addedActivity.rate,
                            );
                            print("date  ...${value}");
                          },
                          focusNode: dateFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add a date.';
                            }
                            return null;
                          }),
                      CustomTextField(
                        icon: const Icon(Icons.money),
                        horizontalPadding: 27,
                        hintext: 'price',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        // focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          // FocusScope.of(context)
                          //     .requestFocus(_taxFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a price.';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number.';
                          }
                          if (int.parse(value) <= 0) {
                            return 'Please enter a number greater than zero.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          addedActivity = ExpenseModel(
                            type: addedActivity.type,
                            title: addedActivity.title,
                            date: addedActivity.date,
                            rate: double.parse(value!),
                            id: addedActivity.id,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomeButton(
                    butionText: "ADD",
                    buttonTopPadding: MediaQuery.of(context).size.width * 0.05,
                    buttionColor: const Color(0xff2182BA),
                    onPressed: () {
                      saveForm();
                    },
                  ),
                  CustomeButton(
                    butionText: "CANCEL",
                    buttonTopPadding: MediaQuery.of(context).size.width * 0.05,
                    buttionColor: const Color(0xff2182BA),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveForm() async {
    final isValid = form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    form.currentState?.save();

    Provider.of<ExpenseProvider>(context, listen: false)
        .addActivity(context, addedActivity);

    Navigator.of(context).pop();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);

      setState(() {
        dateinput.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }
}
