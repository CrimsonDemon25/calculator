import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(title: 'Calculator', home: Calculator()));
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  double result = 0;
  String expression = '';
  double equationfont = 38;
  double resultfont = 48;
  ButtonPressed(String ButtonText){
setState(() {
  if(ButtonText == "C"){
    equation = "";
    result = 0;
    equationfont = 38;
    resultfont = 48;
  }
  else if(ButtonText == "⌫"){
    equation = equation.substring(0,equation.length-1);
    equationfont = 48;
    resultfont = 38;
    if(equation =="0"){
      equation = "0";
    }
  }
  else if(ButtonText == "="){
    equationfont = 28;
    resultfont = 48;
    expression=equation;
    expression =expression.replaceAll('x', '*');
    expression=expression.replaceAll("÷", "/");
    try{
      Parser p = new Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval;
    }
    catch(e){
      result = 001;
    }
  }
  else{
    equationfont = 38;
    resultfont = 48;
    if(equation ==0){
      equation=ButtonText;

    }
    equation = equation + ButtonText;}
});
  }
  Widget buildButton(String ButtonText, double ButtonHeight, Color ButtonColor,
      Color TextColor) {
    return Container(
      width: MediaQuery.of(context).size.width * ButtonHeight,
      child: Table(
        children: [
          TableRow(children: [
            Container(
              height: MediaQuery.of(context).size.width * ButtonHeight,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: ButtonColor,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () => ButtonPressed(ButtonText),
                  child: Text(
                    ButtonText,
                    style: GoogleFonts.lato(fontSize: 48, color: TextColor),
                    textAlign: TextAlign.center,
                  )),
            )
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter Calculator",
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => info()),
                      );
                    },
                    icon: Icon(Icons.info))
              ],
              backgroundColor: Colors.black38,
              title: Text('FlutterCalculator',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            body: Column(children: [
              Container(clipBehavior: Clip.none,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    equation,
                    style: GoogleFonts.lato(
                        fontSize: equationfont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              Container(clipBehavior: Clip.none,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Text(
                    result.toString(),
                    style: GoogleFonts.lato(
                        fontSize: resultfont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              Expanded(
                  child: Divider(
                color: Colors.white,
              )),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(clipBehavior: Clip.none,
                    width: MediaQuery.of(context).size.width * 1,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buildButton("", 0.2, Colors.black45, Colors.black),
                            buildButton("C", 0.2, Colors.white, Colors.black),
                            buildButton("⌫", 0.2, Colors.white, Colors.black),
                            buildButton("÷", 0.2, Colors.white, Colors.black),],),

                        TableRow(children: [
                          buildButton("7", 0.2, Colors.black45, Colors.amberAccent),
                          buildButton("8", 0.2, Colors.black45, Colors.amberAccent),
                          buildButton("9", 0.2, Colors.black45, Colors.amberAccent),
                          buildButton("x", 0.2, Colors.white, Colors.black)]),

                        TableRow(children: [
                            buildButton("4", 0.2, Colors.black45, Colors.amberAccent),
                            buildButton("5", 0.2, Colors.black45, Colors.amberAccent),
                            buildButton("6", 0.2, Colors.black45, Colors.amberAccent),
                            buildButton("-", 0.2, Colors.white, Colors.black)]),

                        TableRow(
                            children:[
                              buildButton("1", 0.2, Colors.black45, Colors.amberAccent),
                              buildButton("2", 0.2, Colors.black45, Colors.amberAccent),
                              buildButton("3", 0.2, Colors.black45, Colors.amberAccent),
                              buildButton("+", 0.2, Colors.white, Colors.black)]),
                        TableRow(
                          children: [
                            buildButton("%", 0.2, Colors.white, Colors.black),
                            buildButton("0", 0.2, Colors.black45, Colors.amberAccent),
                            buildButton(".", 0.2, Colors.white, Colors.black),
                            buildButton("=", 0.2, Colors.white, Colors.black),],)
                      ],
                    )),
              ])
            ])));
  }
}

class info extends StatelessWidget {
  const info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'info',
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: Colors.black45,
                title: Text('Information',
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold))),
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'This app was developed by Ali Abbas Lilani'
                    '           aliabbas.lilani@gmail.com',
                    style: GoogleFonts.lato(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ))
            ])));
  }
}
