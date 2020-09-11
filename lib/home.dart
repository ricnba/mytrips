import 'package:conversor/converter.dart';
import 'package:conversor/tip.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(" My Trips ", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Center(
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
                    width: 200,
                    height: 200,
                    child: RaisedButton(
                        child: Icon(Icons.monetization_on, color: Colors.white, size: 140,),
                        color: Colors.blueAccent,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> Converter()));
                        }),
                  )
                  ,
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    child: RaisedButton(
                      child: Icon(Icons.thumb_up,color: Colors.white, size: 140),
                        color: Colors.blueAccent,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> Tips()));
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
