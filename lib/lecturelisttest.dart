import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subjectevaluator/model/course.dart';
import 'package:subjectevaluator/model/survey.dart';
import 'package:subjectevaluator/uiwidget/fancy_button.dart';
import 'sectionlist.dart';
import 'listsubjet.dart';
import 'landing.dart';
import 'colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import 'dart:typed_data';


final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(count,
          (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

class PickLecturer extends StatefulWidget{

  final Course course;



  PickLecturer ({Key key,this.course}):super(key:key);
  @override
  _PickLecturerState createState() =>new _PickLecturerState();

}

class _PickLecturerState extends State<PickLecturer> {

  _PickLecturerState(): _sizes =_createSizes(_kItemCount).toList();


  static const int _kItemCount = 50;
  List<IntSize> _sizes;

  Survey asurvey = new Survey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lecturer for ${widget.course.name}"),
        elevation: 0.0,
      ),
     /* body: StaggeredGridView.countBuilder(
        primary: false,
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,

          itemBuilder: (context, index)=> new _Tile(_sizes[index],index ),
          staggeredTileBuilder: (index)=> new StaggeredTile.fit(2),
      ),*/
     
     body: StreamBuilder( stream: Firestore.instance.collection('lecturers').where('facultyId', isEqualTo: widget.course.Id).snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

              if(!snapshot.hasData){
                return Center(
                  child: Text("No lecturer found for this faculty, please come back later" ,
                    style: TextStyle(color: kShrineAltYellow) ,) ,
                );

                  //CircularProgressIndicator();
              } else{

              List<DocumentSnapshot> documents = snapshot.data.documents;
              _sizes = _createSizes(documents.length).toList();

                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: documents.length,

                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,

                  itemBuilder: (context, index) =>
                  new _Tile(_sizes[index], index,
                      documents[index], createSurvey),
                  staggeredTileBuilder: (index) => new StaggeredTile.fit(2),

                ); //staggered view
              }
         }
     ),//streambuilder

    );//scaffold
  }


  void _updateSurveyData(String docId, String lecturer){
    setState(() {
      asurvey = Survey(Id: docId);
      print(asurvey.Id);
    });

    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> IndicateSubject(
          course: widget.course,
          lecturer: lecturer,
          survey: asurvey,
        )
    ));
    //print(asurvey.Id);
  }



  void createSurvey(String lecturer) {
    var now = DateTime.now();
    CollectionReference reference = Firestore.instance.collection('surveys');
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.add({
        "course_Id": widget.course.Id,
        "course_name": widget.course.name,
        "editing": false,
        "lecturer_name": lecturer,
        "section_one_completed": false,
        "section_one_loaded": false,
        "section_two_completed": false,
        "section_two_loaded": false,
        "section_three_completed": false,
        "section_three_loaded": false,
        "section_four_completed": false,
        "section_four_loaded": false,
        "forget_protocol_triggered": false,
        "start_date": now.toString(),
        "subject_code": "",

      }).then((reference) =>
          _updateSurveyData(reference.documentID, lecturer)
      );

      print(reference.id);
      // widget.asurvey = Survey(Id:reference.id);


    });
  }





}

typedef CreateSurveyCallback = void Function(String lecturer);

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget{

  _Tile(this.size, this.index, this.documentSnapshot, this.onLecturerPicked);

  final IntSize size;
  final int index;
  final DocumentSnapshot documentSnapshot;

final CreateSurveyCallback onLecturerPicked;





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: new Card(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage,
                    image: documentSnapshot.data['photoUrl'].toString()),
                     // image: 'https://picsum.photos/${size.width}/${size.height}/',),
                )
              ],
            ),//stack

            new Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                    //'Image number $index',
                    '${documentSnapshot.data['fullname'].toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    '${documentSnapshot.data['faculty'].toString()}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  new Text(
                    '${documentSnapshot.data['mainSubject'].toString()}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )

          ],
        ),//column
      ),

      onTap: ()async {
        //the on tap here
        await showDialog(
            context: context,
            builder: (BuildContext context){
          return SimpleDialog(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
            children: <Widget>[
              Container(
                color: kShrineAltYellow,
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                height: 110.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(bottom: 10.0),
                    ),
                    Text(
                      'Lecturer:  ${documentSnapshot.data['fullname'].toString()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0,),
                    Text(
                      'You have selected this lecturer, continue?',
                      style: TextStyle(color: kShrineAltDarkGrey, fontSize: 14.0),
                    ),
                  ],
                ),
              ),//container

              Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context, 0);

                },

                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.cancel,
                        color: kShrineSurfaceWhite,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'CANCEL',
                      style: TextStyle(
                          color: kShrineSurfaceWhite, fontWeight: FontWeight.bold),
                    )
                  ],//children
                ),//row
              ),//simpledialogoption

              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context, 1);
                  onLecturerPicked('${documentSnapshot.data['fullname'].toString()}');

                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.check_circle,
                        color: kShrineAltYellow,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Text(
                      'YES',
                      style: TextStyle(
                          color: kShrineAltYellow, fontWeight: FontWeight.bold),
                    )
                  ],//children

                ),//row

              ),
              ],
              )//row
              )
            ],//children
          );//simpledialog


        }
        );//show dialog
      },
    );
  }








}