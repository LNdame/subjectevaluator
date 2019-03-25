import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:subjectevaluator/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class FancyButton extends StatelessWidget{

  final GestureTapCallback onPressed;


  FancyButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RawMaterialButton(
          fillColor: kShrineAltYellow,
        splashColor: kShrineAltLightGrey,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //ImageIcon(AssetImage('assets/icons/logo.png')),
                Icon(FontAwesomeIcons.rocket),
                SizedBox(width: 18.0,),
                Text("Start Survey")
              ],
            ),
        ),

      onPressed: onPressed,
      shape: const StadiumBorder(),

    );
  }
}