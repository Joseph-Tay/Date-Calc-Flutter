import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DateCalc',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  DateTime currentDate = DateTime.now();

  int calcyears;
  int calcmonths;
  int calcdays;
  int testDiff;

  _calcYMD(dateStartvar, dateEndvar) {
    setState(() {
      testDiff = dateEndvar.difference(dateStartvar).inDays;
      diff = dateEndvar.difference(dateStartvar);
      // print(testDiff);
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
        yearunit = (calcyears == 1) ? 'Year' : 'Years';
        monthunit = (calcmonths == 1) ? 'Month' : 'Months';
        dayunit = (calcdays == 1) ? 'Day' : 'Days';

        // print('$calcyears $yearunit $calcmonths $monthunit $calcdays $dayunit');
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
        yearunit = (calcyears == 1) ? 'Year' : 'Years';
        monthunit = (calcmonths == 1) ? 'Month' : 'Months';
        dayunit = (calcdays == 1) ? 'Day' : 'Days';

        // print('$calcyears $yearunit $calcmonths $monthunit $calcdays $dayunit');
      }
    });
  }

  void _startdatetap() {
    showModalBottomSheet(
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime dateStart) {
              // print(dateStart);
              dateStartvar = dateStart;
              // print(dateStartvar);
              setState(() {
                startdate = dateStart.day.toString() +
                    '.' +
                    dateStart.month.toString() +
                    '.' +
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
  }

  void _enddatetap() {
    showModalBottomSheet(
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime dateEnd) {
              // print(dateEnd);
              dateEndvar = dateEnd;
              // print(dateEndvar);
              setState(() {
                enddate = dateEnd.day.toString() +
                    '.' +
                    dateEnd.month.toString() +
                    '.' +
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
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Date Difference Calculator"),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: Container(
          height: screenSize.height - 56,
          width: screenSize.width,
          color: Colors.blueGrey,
          child: Column(
            children: [
              Container(
                height: (screenSize.height) / 2,
                width: screenSize.width,
                color: Colors.transparent,
                child: Expanded(
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: _startdatetap,
                        child: Container(
                          color: Colors.blueGrey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: Colors.blueGrey[900],
                                    size: 60.0,
                                  ),
                                ),
                                SizedBox(height: 15),
                                startdate == null
                                    ? Container(
                                        child: Text(' ',
                                            style: TextStyle(
                                                fontSize: 25, height: 1.15)))
                                    : Text(
                                        '$startdate',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          height: 1.15,
                                        ),
                                      ),
                              ]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: Icon(
                                Icons.compare_arrows,
                                size: 50.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: _enddatetap,
                        child: Container(
                          color: Colors.blueGrey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.blueGrey[900],
                                    size: 60.0,
                                  ),
                                ),
                                SizedBox(height: 15),
                                enddate == null
                                    ? Container(
                                        child: Text(' ',
                                            style: TextStyle(
                                                fontSize: 25, height: 1.15)))
                                    : Text(
                                        '$enddate',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          height: 1.15,
                                        ),
                                      ),
                              ]),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                height: (screenSize.height / 2) - 56,
                width: screenSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _calcYMD(dateStartvar, dateEndvar),
                        child: Container(
                          color: Colors.blueGrey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.calculate,
                                    color: Colors.blueGrey[900],
                                    size: 80.0,
                                  ),
                                ),
                                SizedBox(height: 15),
                                diff == null
                                    ? Container(
                                        child: Text(
                                          ' ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35,
                                            height: 1.15,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        '$calcyears Y | $calcmonths M | $calcdays D',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          height: 1.15,
                                        ),
                                      ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
