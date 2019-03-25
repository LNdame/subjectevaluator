import 'package:flutter/material.dart';
import 'dart:async';
import 'colors.dart';
class SplashPage extends StatefulWidget{


  @override
  _SplashPageState createState() =>new _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();


    Future.delayed(Duration(seconds: 3)).then((dynamic) =>

        Navigator.popAndPushNamed(context, '/landing')
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/icons/logolong.png'),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kShrineAltYellow) ),
              SizedBox(width: 20.0,),
              Text("Please Wait..."),

            ], //row widget
          ) //row
        ], //col widget
      ), //column
    );
  }


}