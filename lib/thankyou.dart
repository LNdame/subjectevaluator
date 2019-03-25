
import 'package:flutter/material.dart';
import 'package:subjectevaluator/uiwidget/profile_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'landing.dart';
import 'colors.dart';


class ThankYou extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Center(
        child: Column(

          children: <Widget>[
            Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.smileBeam,
              size: 100.0,
              color: kShrineAltYellow,
            ),
            SizedBox(height: 30.0,),
            ProfileTile(
              title: "Thanks!!!",
              subtitle:"Thank you for taking the survey" ,
            )

          ],
        ),
            ),//expanded
      Container(
        color: kShrineAltYellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Text('Back to Start'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color:  Theme.of(context).primaryColor ,
                  )),
              onPressed: () {
                // TODO:
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LandingPage()));

              },
            ),//right fb
          ],
        ),
      ),//container

          ],//widget
        ),//column
      ),

    );


  }
}