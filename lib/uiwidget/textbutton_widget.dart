import 'package:flutter/material.dart';


class TextButtonWid extends StatefulWidget{

 final String title;
 final bool isOnLight;

  const TextButtonWid({this.title,this.isOnLight});

  @override
  _TextButtonWidState createState()=> new _TextButtonWidState();

}

class _TextButtonWidState extends State<TextButtonWid> {

    Widget _buildTextButton(String title, bool isOnLight){
      return FlatButton(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Text(title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: isOnLight ? Theme.of(context).primaryColor : Colors.white,
            )
        ),
        onPressed: (){

        },
      );
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTextButton(widget.title, widget.isOnLight);
  }
}