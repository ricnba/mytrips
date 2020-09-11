import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=739776bd";


Future<Map> getData() async {
  http.Response response = await http.get(request);
  print(response.body);
  return json.decode(response.body);
}

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  

  final realCtrl = TextEditingController();
  final dollarCtrl = TextEditingController();
  final euroCtrl = TextEditingController();

  double dolar;
  double euro;

  void _realChange (String text){
    double real = double.parse(text);
    dollarCtrl.text = (real/dolar).toStringAsFixed(2);
    print(dolar);
    euroCtrl.text = (real/euro).toStringAsFixed(2);
  }
  void _dollarChange (String text){
    double dollar = double.parse(text);
    realCtrl.text = (dollar*dolar).toStringAsFixed(2);
    euroCtrl.text = (dollar*dolar/euro).toStringAsFixed(2);
  }
  /*void _euroChange (String text){
    double euro = double.parse(text);
    realCtrl.text = (euro*this.euro).toStringAsFixed(2);
    dollarCtrl.text = (euro*this.euro/dolar).toStringAsFixed(2);
  }*/
  void clear (){
    realCtrl.text = "";
    dollarCtrl.text = "";
    euroCtrl.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando dados...",
                    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Carregando dados...",
                      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.lightBlueAccent,),
                        buildTextField("R\$", "R\$  ", realCtrl, _realChange),
                        Divider(),
                        buildTextField("US\$", "US\$  ", dollarCtrl, _dollarChange ),

                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
Widget buildTextField ( String label, String prefix, TextEditingController ctrl, Function f){
  return TextField(
    controller: ctrl,
    decoration: InputDecoration(
      labelText: label,
        labelStyle: TextStyle(color: Colors.lightBlueAccent),
        border: OutlineInputBorder(),
        prefixText: prefix,
      prefixIcon: Image.network("https://www.countryflags.io/be/flat/64.png")
    ),
    style: TextStyle(
      color: Colors.lightBlueAccent, fontSize: 25.0,
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}