import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData.dark(),
      home: MyCalculator(),
    );
  }
}
class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {

  double result = 0.0;
  String strResult = '';
  String operator = '';
  double firstNumber = 0.0;
  bool isFirstNumberAfterOperationButton = true;
  String equation ='';


  void onDigitPress(String text){
    print("Digit pressed $text");

    if(text == '+' || text == '-' || text == '÷' || text == 'x') {
      operator = text;
      firstNumber = result;
      strResult = '';
      setState(() {
        result = 0;
        equation += text;
      });
    }

    else if(text == 'C'){
      setState(() {
        firstNumber = 0.0;
        result = 0;
        strResult = '';
        equation = '';
      });


    }
    else if(text == '⌫'){
      if (equation == ''){
        equation = '';
      }
      else{
      setState(() {
        equation = equation.substring(0, equation.length - 1);
      });
      }

    }

    else if(text == '='){
      switch (operator) {
        case '+' :
          setState(() {
            result += firstNumber;
          });
          strResult = '';
          break;

        case '-':
          setState(() {
            result = firstNumber - result;
          });
          strResult = '';
          break;

        case '÷':
          setState(() {
            result = firstNumber/result;
          });
          strResult = '';
          break;

        case 'x':
          setState(() {
            result *= firstNumber;
            strResult = '';
          });
          break;


      }
      setState(() {
        firstNumber=0.0;
        equation= '';
      });
    }
    else {
      var tempResult;
      equation += text;
      if (isFirstNumberAfterOperationButton) {
        tempResult = text;
        isFirstNumberAfterOperationButton = false;
      } else {
        tempResult = strResult + text;
      }
      var temp = double.tryParse(tempResult);
      if (temp != null) {
        strResult = tempResult;
        setState(() {
          result = temp ?? result;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '$equation',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  '$result',
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
            Expanded(

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('C', Colors.red[900]),
                  buildCalcButton('⌫', Colors.lightGreen[400]),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('7', Colors.black54),
                  buildCalcButton('8', Colors.black54),
                  buildCalcButton('9', Colors.black54),
                  buildCalcOperatorButton('÷', Colors.black26),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('4', Colors.black54),
                  buildCalcButton('5', Colors.black54),
                  buildCalcButton('6', Colors.black54),
                  buildCalcOperatorButton('x', Colors.black26),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('1', Colors.black54),
                  buildCalcButton('2', Colors.black54),
                  buildCalcButton('3', Colors.black54),
                  buildCalcOperatorButton('+', Colors.black26),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCalcButton('.', Colors.black26),
                  buildCalcButton('0', Colors.black54),
                  buildCalcOperatorButton('=', Colors.black26),
                  buildCalcOperatorButton('-', Colors.black26),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildCalcButton(String text, Color color) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          onDigitPress(text);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Colors.white60,
              width: 1.0,
              style: BorderStyle.solid,
            )),
        color: color,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Expanded buildCalcOperatorButton(String text, Color color) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          onDigitPress(text);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Colors.white60,
              width: 1.0,
              style: BorderStyle.solid,
            )),
        color: color,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: Colors.lightGreenAccent,
          ),
        ),
      ),
    );
  }

}



