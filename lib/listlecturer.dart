import 'package:flutter/material.dart';
import 'package:subjectevaluator/model/course.dart';
import 'package:subjectevaluator/model/survey.dart';
import 'package:subjectevaluator/uiwidget/fancy_button.dart';
import 'sectionlist.dart';
import 'landing.dart';
import 'colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IndicateLecturer extends StatefulWidget{

  final Course course;

  IndicateLecturer({Key key,this.course}):super(key:key);

  @override
  _IndicateLecturerState createState() {
    return new _IndicateLecturerState();
  }
}

class _IndicateLecturerState extends State<IndicateLecturer> {
  final _lecturerController = new TextEditingController();
  Survey asurvey = new Survey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Lecture for ${widget.course.name}"),
      ),//appbar

      body: Padding(
          padding: EdgeInsets.all(16.0),
        child: Center(
          child:
          AccentColorOverride(
            color: kShrineAltYellow,

            child: TextField(
            controller: _lecturerController,
            decoration: InputDecoration(
              //filled: true,
              labelText: 'Lecturer',
            ),
          ),
          ),
        ),

      ),//body

      floatingActionButton: FancyButton(onPressed: (){

        createSurvey();

       /* Navigator.push(context, MaterialPageRoute(
            builder: (context)=> SectionList(
              course: widget.course,
              lecturer: _lecturerController.text,
              survey: asurvey,
            )
        ));*/
      }),

    );//scaffold
  }

  void _updateSurveyData(String docId){
    setState(() {
      asurvey = Survey(Id: docId);

    });

    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> SectionList(
          course: widget.course,
          lecturer: _lecturerController.text,
          survey: asurvey,
        )
    ));
    //print(asurvey.Id);
  }


  void createSurvey()
  {

    var now  = DateTime.now();
    CollectionReference reference = Firestore.instance.collection('surveys');
    Firestore.instance.runTransaction((Transaction transaction)async{

       await reference.add({
                             "course_Id":widget.course.Id,
                             "course_name":widget.course.name,
                             "editing":false,
                             "lecturer_name":_lecturerController.text,
                             "section_one_completed":false,
                             "section_two_completed":false,
                             "section_three_completed":false,
                             "section_four_completed":false,
                             "forget_protocol_triggered":false,
                              "start_date":now.toString(),

       }).then((reference)=>
           _updateSurveyData(reference.documentID)
       );

       print(reference.id);
      // widget.asurvey = Survey(Id:reference.id);


    });



  }


}