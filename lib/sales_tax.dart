import 'dart:convert';
import 'dart:ui';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:http/http.dart' as http;



class Impostos extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Impostos> {

  double tax;

  Country _selectedSecondCupertinoCountry =
  CountryPickerUtils.getCountryByIsoCode('US');

  TextEditingController prodCtrl = TextEditingController();
  TextEditingController taxCtrl = TextEditingController();
  TextEditingController totalCtrl = TextEditingController();

  void calcImposto (String text){
    double valorProduto = double.parse(prodCtrl.text);
    double valorTax = (valorProduto*(tax/100));
    taxCtrl.text = valorTax.toStringAsFixed(2);
    totalCtrl.text = (valorProduto + valorTax).toStringAsFixed(2);
  }

  void clear() {
    prodCtrl.text = "";
    taxCtrl.text = "";
    totalCtrl.text = "";
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedSecondCupertinoCountry.isoCode) {
      case 'AR':
        tax = 21;
        break;
      case 'DE':
        tax = 19;
        break;
      case 'GB':
        tax = 20;
        break;
      case 'US':
        tax = 7.25;
        break;
      case 'CA':
        tax =5;
        break;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Calculador de Impostos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              //  Card(child: CountryPickerDropdown()),
              TextField(
                controller: prodCtrl,
                onChanged: calcImposto,
                decoration: InputDecoration(
                  labelText: 'Valor Produto',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: taxCtrl,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Valor Imposto',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: totalCtrl,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Valor Total',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                keyboardType: TextInputType.number,
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
                          Flexible(child: Text('$tax %'.toString())),
                          SizedBox(width: 12.0),
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
        ));
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
            calcImposto(prodCtrl.text);
          }),
          itemFilter: (c) => ['AR', 'CA', 'DE', 'GB', 'US'].contains(c.isoCode),
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
