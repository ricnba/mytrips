import 'package:conversor/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  final List<String> buttons = [
    'C', 'Del', '/', '*',
    '7', '8', '9', '+',
    '4', '5', '6', '-',
    '1', '2', '3',  '.',
    '(', "0", ")", '='
  ];
  var question = '';
  var answer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("Calculadora"),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(question, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), )),
                    Container(
                      padding: EdgeInsets.only(right: 16),
                      alignment: Alignment.centerRight,
                        child: Text(answer, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold), )),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 2.2),),
                      itemCount: buttons.length,
                      itemBuilder: (_, index){
                        //clear button
                       if(index == 0 ){
                         return CalcButtons(
                             Colors.greenAccent,
                             Colors.blueAccent,
                             buttons[index],
                             (){
                               setState(() {
                                 answer = '';
                                 question = '';
                               });
                             });
                         //delete button
                       } else if(index == 1){
                         return CalcButtons(
                             Colors.redAccent,
                             Colors.blue,
                             buttons[index],
                             (){
                               setState(() {
                                 question = question.substring(0, question.length-1);
                               });
                             });
                         //equals
                         }else if(index == buttons.length-1){
                         return CalcButtons(
                             Colors.greenAccent,
                             Colors.blueAccent,
                             buttons[index],
                                 (){
                               setState(() {
                                 equalPressed();
                               });
                             });
                       }else{
                         return CalcButtons(
                             isOperator(buttons[index]) ? Colors.blueAccent : Colors.white,
                             isOperator(buttons[index]) ? Colors.white : Colors.blueAccent,
                             buttons[index],
                             (){
                               setState(() {
                                 question += buttons[index];
                               });
                             }
                         );
                       }
                      })
                  ),
              )
              ),
        ],),
      ),
    );
  }
  bool isOperator (String x){
    if(x == '/' || x == '*' || x == '-' || x == '+' || x == '=' || x == '.') {
      return true;
    }return false;
  }

  void equalPressed (){
    String finalQuestion = question;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toStringAsFixed(2);


  }
}
