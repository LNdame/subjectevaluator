import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'colors.dart';
import 'package:subjectevaluator/model/course.dart';
import 'listlecturer.dart';
import 'lecturelisttest.dart';


class CourseList extends StatefulWidget{


  @override
  _CourseListState createState()=> new _CourseListState();

}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a faculty"),
        centerTitle: true,
      ),//appbar

      body: StreamBuilder(
            stream: Firestore.instance.collection('courses').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData) return CircularProgressIndicator();

              return CourseListView(documents: snapshot.data.documents);
          }
      ),//streambuilder

    );//scaffold
  }
}


class CourseListView extends StatelessWidget{

  final List<DocumentSnapshot> documents;


  CourseListView({@required this.documents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: documents.length,

        itemBuilder:(BuildContext context, int index){
          String name = documents[index].data['name'].toString();
          return ListTile(
            title: Card(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(4.0),
                  border: Border.all(color: kShrineAltLightGrey,),
                ),//decoration
                padding: EdgeInsets.only(left: 16.0),
                margin: EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Text(name)),
                  ],//widget
                ),
              ),
            ),//container

            onTap: (){

            Course acourse = Course(
              Id: documents[index].documentID ,
              name: name,
             );

            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> PickLecturer(course: acourse,),// IndicateLecturer(course: acourse,)
            ));

            },//ontap
          );//listtile


        }
    );//builder
  }
}