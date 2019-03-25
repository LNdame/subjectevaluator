import 'package:flutter/material.dart';
import 'colors.dart';
import 'testpagefirebase.dart';
import 'sectionlist.dart';
import 'package:subjectevaluator/uiwidget/rangeslider.dart';
import 'testslider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'listcourse.dart';

import 'package:subjectevaluator/uiwidget/fancy_button.dart';

class LandingPage extends StatefulWidget{



  @override
  _LandingPageState createState() => _LandingPageState();

}

class _LandingPageState extends State<LandingPage> {
  final _usernameController = new TextEditingController();
  final _passwordController = TextEditingController();

  String _value = null;
  String _fromFirestoreValue = null;
  List<String> _values = new List<String>();
  DocumentSnapshot _documentSnapshot;

  @override
  void initState() {

    /*Firestore.instance.collection('courses').snapshots().
    listen( (data)=>
        data.documents.forEach((doc)=> _values.add(doc['name']))

    );*/
    
   _values.addAll(["Lecturer 1","Lecturer 2","Lecturer 3","Lecturer 4","Lecturer 5"]);
    _value= _values.elementAt(0);

    _documentSnapshot = null ;
    
  }

  void _onChanged(String value){
    setState(() {
      _value = value;
      print(_value);
    });
  }

  void _onFirelistChanged(DocumentSnapshot value){
    setState(() {
      _documentSnapshot = value;
      print(_documentSnapshot.data["name"].toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              children: <Widget>[
                SizedBox(height: 20.0),
                Column(
                  children: <Widget>[
                    Image.asset('assets/icons/logo.png',
                     // color: kShrineAltYellow,
                    ),

                  ],
                ),
                SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("1", style:  TextStyle(
                      fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: Text("The questionnaire is answered by students.",
                        style:  TextStyle(
                          fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],

                ),//row
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("2", style:  TextStyle(
                      fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                    ),
                    ),
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: Text("The aim of this questionnaire is to determine how you experience the lecturer's teaching and your learning in a particular module / course.",
                        style:  TextStyle(
                          fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],

                ),//row

                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("3", style:  TextStyle(
                      fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                    ),
                    ),
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: Text("Your feedback is confidential and anonymous. No names are needed.",
                        style:  TextStyle(
                          fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],

                ),//row

                SizedBox(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("4", style:  TextStyle(
                      fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                    ),
                    ),
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: Text("Answer codes are provided with each question. Indicate your choice on the form. Only one choice per question is allowed",
                        style:  TextStyle(
                          fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],

                ),//row
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("5", style:  TextStyle(
                      fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                    ),
                    ),
                    SizedBox(width: 16.0,),
                    Expanded(
                      child: Text("Section 4 is answered on the spaces provided",
                        style:  TextStyle(
                          fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                        ),
                      ),
                    )

                  ],

                ),//row
                SizedBox(height: 60.0),
                /*
                AccentColorOverride(
                  color: kShrineAltYellow,
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      //filled: true,
                      labelText: 'Course',
                    ),
                  ),
                ),
                SizedBox(height: 12.0),

                DropdownButton(
                    value: _value,
                    items: _values.map((value){
                      return DropdownMenuItem(
                        value: value,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.book),
                              Text("${value}"),
                            ],
                          )
                      );

                    }).toList(),
                    onChanged: (value){
                      _onChanged(value);
                      
                    }
                ),
                SizedBox(height: 12.0),

                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("courses").snapshots(),
                    builder: (context, snapshot){
                    var length =snapshot.data.documents.length;
                   _documentSnapshot =  snapshot.data.documents.elementAt(0);
                    return DropdownButton(
                      value: _documentSnapshot,//.data["name"].toString(),
                      items: snapshot.data.documents.map((DocumentSnapshot dcs){
                        return DropdownMenuItem(
                          value:dcs,//.data['name'].toString() ,
                          child: Text(dcs.data['name'].toString()),
                        );
                      }
                      ).toList(),
                      onChanged: (DocumentSnapshot value){
                        _onFirelistChanged(value);
                      },
                      hint: Text("Choose a course"),
                    );//dropdown

                    }//builder
                ),
                




                SizedBox(height: 12.0),
                AccentColorOverride(
                  color: kShrineAltYellow,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      //  filled: true,
                      labelText: 'Lecturer Name',
                    ),

                  ),
                ),

                ButtonBar(
                  children: <Widget>[
                    AccentColorOverride(
                      color: kShrineAltYellow,
                    child:FlatButton(
                      child: Text('CANCEL'),

                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0))
                      ),

                      onPressed: (){
                        //when pressed
                        _usernameController.clear();
                        _passwordController.clear();
                      },
                    ),//flatb ,
                    ),


                    RaisedButton(
                      child: Text('NEXT'),
                      elevation: 8.0,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0))
                      ),
                      onPressed: (){
                        //when pressed
                        Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context)=> SectionList(),
                        )
                        );//anvigator
                       // Navigator.pop(context);
                      },
                    ),
                  ],
                )*/

              ],// <Widget>[]


        ),//ListView
     ),//safearea
      floatingActionButton: FancyButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context)=> CourseList(),
        )
        );//anvigator
      }) ,
    );//scaffold
  }



 // Route<dynamic> _getRoute(RouteSettings settings){}
}





class AccentColorOverride extends StatelessWidget{
  const AccentColorOverride ({Key key, this.color, this.child}):super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}
