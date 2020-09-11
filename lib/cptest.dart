import 'dart:convert';
import 'dart:ui';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:http/http.dart' as http;

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=739776bd";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  print(response.body);
  return json.decode(response.body);
}

class DemoPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DemoPage> {
  Country _selectedCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('BR');
  Country _selectedSecondCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('US');

  final firstCtrl = TextEditingController();
  final secondCtrl = TextEditingController();
  final scrollController = ScrollController();

  double secondCur;
  double dolar;
  double euro;
  double peso;
  double libra;

  void _firstCtrlChange(String text) {
    double first = double.parse(text);
    secondCtrl.text = (first / secondCur).toStringAsFixed(2);
    print(secondCur);
  }

  void _secondCtrlChange(String text) {
    switch (_selectedSecondCupertinoCountry.isoCode) {
      case 'AR':
        secondCur = peso;
        break;
      case 'GB':
        secondCur = libra;
        break;
      case 'DE':
        secondCur = euro;
        break;
      case 'US':
        secondCur = dolar;
        break;
    }

    double second = double.parse(text);
    firstCtrl.text = (secondCur * second).toStringAsFixed(2);
  }

  void clear() {
    firstCtrl.text = "";
    secondCtrl.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Country Pickers Demo'),
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
                      style: TextStyle(color: Colors.black, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Carregando dados...",
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    dolar =
                        snapshot.data["results"]['currencies']["USD"]["buy"];
                    euro = snapshot.data["results"]['currencies']["EUR"]["buy"];
                    peso = snapshot.data["results"]['currencies']["ARS"]["buy"];
                    libra =
                        snapshot.data["results"]['currencies']["GBP"]["buy"];

                    String iso;
                    switch (_selectedSecondCupertinoCountry.isoCode) {
                      case 'AR':
                        iso = 'ARS';
                        break;
                      case 'BR':
                        iso = 'BRL';
                        break;
                      case 'DE':
                        iso = 'EUR';
                        break;
                      case 'GB':
                        iso = 'GBP';
                        break;
                      case 'US':
                        iso = 'USD';
                        break;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          //  Card(child: CountryPickerDropdown()),
                          Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_selectedCupertinoCountry.name),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      CountryPickerUtils.getDefaultFlagImage(
                                          _selectedCupertinoCountry),
                                      SizedBox(width: 8.0),
                                      Flexible(child: Text('BRL')),
                                      SizedBox(width: 12.0),
                                      Flexible(
                                          flex: 8,
                                          child: buildTextField("\$", firstCtrl,
                                              _firstCtrlChange)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_selectedSecondCupertinoCountry.name),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      CountryPickerUtils.getDefaultFlagImage(
                                          _selectedSecondCupertinoCountry),
                                      SizedBox(width: 8.0),
                                      Flexible(child: Text(iso)),
                                      SizedBox(width: 12.0),
                                      Flexible(
                                          flex: 8,
                                          child: buildTextField("\$",
                                              secondCtrl, _secondCtrlChange)),
                                    ],
                                  ),
                                  onTap: _openSecondCupertinoCountryPicker,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 370,
                            height: 50,
                            child: RaisedButton(
                              onPressed: clear,
                              child: Text("Limpar"),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }

  void d() {
    setState(() {});
  }

  void _openSecondCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.white,
          itemBuilder: _buildSecondCupertinoItem,
          pickerSheetHeight: 300.0,
          pickerItemHeight: 55,
          initialCountry: _selectedSecondCupertinoCountry,
          onValuePicked: (Country country) => setState(() {
            _selectedSecondCupertinoCountry = country;
            clear();
          }),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'US'].contains(c.isoCode),
        );
      });

  Widget _buildSecondCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 8.0),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Flexible(
              child: Text(
            country.name,
            style: TextStyle(color: Colors.black),
          ))
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController ctrl, Function f) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      onChanged: f,
      keyboardType: TextInputType.number,
    );
  }
}
