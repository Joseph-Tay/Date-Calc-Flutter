import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DateApp(),
    );
  }
}

class DateApp extends StatefulWidget {
  @override
  _DateAppState createState() => _DateAppState();
}

class _DateAppState extends State<DateApp> {
  String startdate;
  String enddate;
  String yearunit;
  String monthunit;
  String dayunit;

  Duration diff;

  DateTime selectedDate = DateTime.now();
  DateTime dateEndvar;
  DateTime dateStartvar;

  int calcyears;
  int calcmonths;
  int calcdays;
  int testDiff;

  calcYMD(dateStartvar, dateEndvar) {
    setState(() {
      testDiff = dateEndvar.difference(dateStartvar).inDays;
      diff = dateEndvar.difference(dateStartvar);
      print(testDiff);
      if (testDiff > 0) {
        calcyears = dateEndvar.year - dateStartvar.year;
        calcmonths = dateEndvar.month - dateStartvar.month;
        calcdays = dateEndvar.day - dateStartvar.day;
        if (calcmonths < 0 || (calcmonths == 0 && calcdays < 0)) {
          calcyears--;
          calcmonths += (calcdays < 0 ? 11 : 12);
        }
        if (calcdays < 0) {
          final monthAgo =
              DateTime(dateEndvar.year, dateEndvar.month - 1, dateStartvar.day);
          calcdays = dateEndvar.difference(monthAgo).inDays + 1;
        }
        if (calcyears == 1) {
          yearunit = 'Year';
        } else {
          yearunit = 'Years';
        }
        if (calcmonths == 1) {
          monthunit = 'Month';
        } else {
          monthunit = 'Months';
        }
        if (calcdays == 1) {
          dayunit = 'Day';
        } else {
          dayunit = 'Days';
        }
        print('$calcyears $yearunit $calcmonths $monthunit $calcdays $dayunit');
      }
      if (testDiff < 0) {
        calcyears = dateStartvar.year - dateEndvar.year;
        calcmonths = dateStartvar.month - dateEndvar.month;
        calcdays = dateStartvar.day - dateEndvar.day;
        if (calcmonths < 0 || (calcmonths == 0 && calcdays < 0)) {
          calcyears--;
          calcmonths += (calcdays < 0 ? 11 : 12);
        }
        if (calcdays < 0) {
          final monthAgo = DateTime(
              dateStartvar.year, dateStartvar.month - 1, dateEndvar.day);
          calcdays = dateStartvar.difference(monthAgo).inDays + 1;
        }
        if (calcyears == 1) {
          yearunit = 'Year';
        } else {
          yearunit = 'Years';
        }
        if (calcmonths == 1) {
          monthunit = 'Month';
        } else {
          monthunit = 'Months';
        }
        if (calcdays == 1) {
          dayunit = 'Day';
        } else {
          dayunit = 'Days';
        }
        print('$calcyears $yearunit $calcmonths $monthunit $calcdays $dayunit');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: Text(
                    "Start date",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      height: 1.15,
                    ),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    showModalBottomSheet(
                      builder: (BuildContext context) {
                        return Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height / 3,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime dateStart) {
                              print(dateStart);
                              dateStartvar = dateStart;
                              print(dateStartvar);
                              setState(() {
                                startdate = dateStart.day.toString() +
                                    '/' +
                                    dateStart.month.toString() +
                                    '/' +
                                    dateStart.year.toString() +
                                    ' ';
                              });
                            },
                            maximumDate: new DateTime(2100, 12, 30),
                            minimumYear: 1900,
                            maximumYear: 2100,
                            mode: CupertinoDatePickerMode.date,
                          ),
                        );
                      },
                      context: context,
                    );
                  },
                ),
                startdate == null
                    ? Container()
                    : Text(
                        '$startdate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          height: 1.15,
                        ),
                      ),
                SizedBox(height: 40),
                MaterialButton(
                  child: Text(
                    "End date",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      height: 1.15,
                    ),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () {
                    showModalBottomSheet(
                      builder: (BuildContext context) {
                        return Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height / 3,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime dateEnd) {
                              print(dateEnd);
                              dateEndvar = dateEnd;
                              print(dateEndvar);
                              setState(() {
                                enddate = dateEnd.day.toString() +
                                    '/' +
                                    dateEnd.month.toString() +
                                    '/' +
                                    dateEnd.year.toString() +
                                    ' ';
                              });
                            },
                            maximumDate: new DateTime(2100, 12, 30),
                            minimumYear: 1900,
                            maximumYear: 2100,
                            mode: CupertinoDatePickerMode.date,
                          ),
                        );
                      },
                      context: context,
                    );
                  },
                ),
                enddate == null
                    ? Container()
                    : Text(
                        '$enddate',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          height: 1.15,
                        ),
                      ),
                SizedBox(height: 40),
                MaterialButton(
                  child: Text(
                    "Calculate Difference",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      height: 1.15,
                    ),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () => calcYMD(dateStartvar, dateEndvar),
                ),
                diff == null
                    ? Container()
                    : Text(
                        '$calcyears $yearunit $calcmonths $monthunit $calcdays $dayunit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          height: 1.15,
                        ),
                      ),
                // if (dateEnd != null && dateStart != null){
                //   var diff = dateStart.difference(dateEnd);
                //   return Container(child:Text('$diff'))
                // }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
