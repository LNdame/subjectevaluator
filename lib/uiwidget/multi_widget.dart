import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MultiWidget extends StatefulWidget{

  final List<String> options;
  final DocumentSnapshot documentSnapshot;



  MultiWidget({this.options, this.documentSnapshot});

  @override
  _MultiWidgetState createState() => _MultiWidgetState();
}


class _MultiWidgetState extends State<MultiWidget>{





  String _value = "";

  Widget multichoiceCard() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[

      SizedBox(height: 15.0,),
    Center(

     child:  Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: widget.options.map((op)=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChoiceChip(
            selectedColor: Colors.yellow,
            label: Text(op,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            selected: _value == op,
            onSelected: (selected){
              setState(() {
                _value = selected ? op:null;
              });//setstate

              Firestore.instance.runTransaction((Transaction trans)async{

                await trans.update(widget.documentSnapshot.reference, {"answer":"${_value}"});

              });

            },//onselected

          ),
        )
        ).toList(),//map
      ),
    )
    ],
  );



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return multichoiceCard();
  }

  @override
  void initState() {

     _value = widget.documentSnapshot.data['answer'].toString();
  }
}