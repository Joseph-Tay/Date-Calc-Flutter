import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(DateCalc());

class DateCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.blueGrey,
         appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
        body: SafeArea(   
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              



            ]
          )  
        
        
        ,)

      ),
    );
  }
}
