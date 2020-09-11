import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}
class _TipsState extends State<Tips> {
  double initialV = 0;
  double endV = 100;
  TextEditingController ctrl = TextEditingController();
  TextEditingController gorjetactrl = TextEditingController();
  TextEditingController totalctrl = TextEditingController();
  double gorjeta =  0;
  double total = 0;
  void calcularGorjeta() {
    setState(() {
      double valorIn = double.parse(ctrl.text);
      gorjetactrl.text = ((valorIn * initialV) / 100).toStringAsFixed(2);
    });
  }
  void calcularTotal() {
    double valorIn = double.parse(ctrl.text);
    totalctrl.text = (valorIn + (valorIn * initialV) / 100).toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("\$ Tips \$"),
          backgroundColor: Colors.lightBlue,
          centerTitle: true,),
        body: Center(
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 400,
                    child: Material(
                      shadowColor: Colors.blue,
                      elevation: 14,
                      color: Colors.blueAccent,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 300,
                        child: Column(
                          children: [
                            TextField(
                              readOnly: debugInstrumentationEnabled,
                              controller: ctrl,
                              decoration: InputDecoration(
                                  labelText: "Valor",
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                  prefixText: "\$  ",
                                  prefixStyle: TextStyle(color: Colors.white, fontSize: 18)
                              ),
                              style: TextStyle(
                                color: Colors.white, fontSize: 25.0,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16,),
                            TextField(
                              readOnly: true,
                              controller: gorjetactrl,
                              decoration: InputDecoration(
                                  labelText: "Gorjeta",
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                  prefixText: "\$  ",
                                  prefixStyle: TextStyle(color: Colors.white, fontSize: 18)
                              ),
                              style: TextStyle(
                                color: Colors.white, fontSize: 25.0,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 26,),
                            TextField(
                              readOnly: true,
                              controller: totalctrl,
                              decoration: InputDecoration(
                                  labelText: "Total",
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                  prefixText: "\$  ",
                                  prefixStyle: TextStyle(color: Colors.white, fontSize: 18)
                              ),
                              style: TextStyle(
                                color: Colors.white, fontSize: 25.0,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Slider(
                      min: 0,
                      max: 100,
                      divisions: 100,
                      value: initialV,
                      label: initialV.toStringAsFixed(0) + " %",
                      onChanged: (newValue) {
                        setState(() {
                          initialV = newValue;
                          calcularGorjeta();
                          calcularTotal();
                        });
                      }),
                  Text(
                    initialV.toStringAsFixed(0) + " % de Gorjeta",
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
