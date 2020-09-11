import 'package:conversor/calc.dart';
import 'package:conversor/converter.dart';
import 'package:conversor/gorjeta.dart';
import 'package:conversor/novo.dart';
import 'package:conversor/sales_tax.dart';
import 'package:conversor/tips.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          " My Trips ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Material(
            shadowColor: Colors.blueGrey,
            elevation: 14,
            child: Container(
              color: Colors.white,
              child: SizedBox(
                height: 420,
                child: Column(
                  children: [
                    Container(
                      child: RaisedButton(
                          child: Text("Conversor"),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Converter()));
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: RaisedButton(
                          child: Text("Calculadora"),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Calculator()));
                          }),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: RaisedButton(
                          child: Text("Impostos"),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Impostos()));
                          }),
                    ),
          Container(
            child: RaisedButton(
                child: Text("Gorjetas"),
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Novo()));
                }),
          )


          ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
