import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonclick(value){
    if (value == "AC"){
      input = '';
      output = '';
    }
    else if(value == "<"){
      if (input.isNotEmpty){
        input = input.substring(0, input.length -1);
      }

    }
    else if(value == '='){
      if(input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith(".0")){
          output = output.substring(0, output.length -2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    }
    else{
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Calculator'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.0),
              // color: Colors.white38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(hideInput ? '' : input,style: TextStyle(fontSize: 48,
                      color: Colors.white),),
                      SizedBox(height: 20,),
                      Text( output ,style: TextStyle(fontSize: outputSize,
                          color: Colors.white.withOpacity(0.7)),),
                      SizedBox(height: 20,),
                    ],
                  ),
            )
            ),
            // Buttons Area
            Row(
              children: [
                button(text: 'AC', buttonbgcolor: Color(0xff969796), tcolor: Colors.black),
                button(text: '<', buttonbgcolor: Color(0xff969796), tcolor: Colors.black),
                button(text: '', buttonbgcolor: Colors.transparent),
                button(text: '/',buttonbgcolor: Color(0xfff1a30c), tcolor: Colors.white),
              ],
            ),
            Row(
              children: [
                button(text: '7'),
                button(text: '8'),
                button(text: '9'),
                button(text: 'x', buttonbgcolor: Color(0xfff1a30c)),
              ],
            ),
            Row(
              children: [
                button(text: '4'),
                button(text: '5'),
                button(text: '6'),
                button(text: '-',buttonbgcolor: Color(0xfff1a30c)),
              ],
            ),
            Row(
              children: [
                button(text: '1'),
                button(text: '2'),
                button(text: '3'),
                button(text: '+',buttonbgcolor: Color(0xfff1a30c)),
              ],
            ),
            Row(
              children: [
                button(text: '%'),
                button(text: '0'),
                button(text: '.'),
                button(text: '=',buttonbgcolor: Colors.orangeAccent),
              ],
            ),
          ],
        )
    );
  }
  Widget button(
  {
    text, tcolor = Colors.white , buttonbgcolor = Colors.white38
}
      ){
    return  Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            primary: buttonbgcolor,
            padding: EdgeInsets.all(22),
          ),
          onPressed: () => onButtonclick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22,
                color: tcolor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
