import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryPick extends StatefulWidget {
  @override
  _CountryPickState createState() => _CountryPickState();
}
class _CountryPickState extends State<CountryPick> {

  final realCtrl = TextEditingController();
  final dollarCtrl = TextEditingController();

  showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(
              backgroundColor: Colors.white,
              onSelectedItemChanged: (value) {
                setState(() {});
              },
              itemExtent: 32.0,
              children: [
                Container(
                    child: Row(
                  children: [
                    Image.network("https://www.countryflags.io/be/flat/64.png",),
                    SizedBox(width: 5,),
                    Text("Belgica", style: TextStyle(fontSize: 16),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Text 2",
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Text 3",
                      style: TextStyle(fontSize: 16),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Text 4",
                      style: TextStyle(fontSize: 16),
                    )),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top:  50),
                child: RaisedButton(onPressed: showPicker)),
          ],
        ),
      ),
    );
  }
}
