import 'package:flutter/material.dart';
import 'package:subjectevaluator/model/course.dart';
import 'package:subjectevaluator/model/survey.dart';
import 'package:subjectevaluator/uiwidget/fancy_button.dart';
import 'sectionlist.dart';
import 'landing.dart';
import 'colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class IndicateSubject extends StatefulWidget{

  final Course course;
  final String lecturer;
  final Survey survey;

  IndicateSubject({Key key,this.course, this.lecturer, this.survey}):assert(course!=null),
        assert(lecturer!=null),
        super(key:key);

  @override
  _IndicateSubjectState createState() {
    return new _IndicateSubjectState();
  }
}

class _IndicateSubjectState extends State<IndicateSubject> {

  final _subjectController = new TextEditingController();


  void updateSubjectCode(String code){
    Firestore.instance.collection("surveys").document(widget.survey.Id).get().then(
        (DocumentSnapshot docSnap){
          Firestore.instance.runTransaction((transaction)async{
            await transaction.update(docSnap.reference, {"subject_code": code});
          }).then((dynamic){

            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> SectionList(
                  course: widget.course,
                  lecturer: widget.lecturer,
                  survey: widget.survey,
                )
            ));
          }).catchError((e){ print(e);});
        }).catchError((e){ print(e);});
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
        "lecturer_name":_subjectController.text,
        "section_one_completed":false,
        "section_two_completed":false,
        "section_three_completed":false,
        "section_four_completed":false,
        "forget_protocol_triggered":false,
        "start_date":now.toString(),

      }).then((reference){}
          //_updateSurveyData(reference.documentID)
      );

      print(reference.id);
      // widget.asurvey = Survey(Id:reference.id);


    });



  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Subject for ${widget.lecturer}"),
      ),//appbar

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child:

             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text("Indicate the subject code for ${widget.lecturer}",
                   style: TextStyle( fontSize: 15.0, fontWeight: FontWeight.w500), ),
                 SizedBox(height: 25.0,),

                 AccentColorOverride(
                   color: kShrineAltYellow,

                   child: TextField(
                     controller: _subjectController,
                     decoration: InputDecoration(
                       //filled: true,
                       labelText: 'Subject Code',
                     ),
                   ),
                 ),


               ],

             )


        ),

      ),//body

      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(onPressed:() {

            if(_subjectController.text.isNotEmpty && _subjectController.text !=null){

              updateSubjectCode(_subjectController.text);

            }else{
              final snackBar = SnackBar(content: Text("Please enter the subject code to continue" ,
                style: TextStyle(color: kShrineErrorRed) ,),);
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },

            backgroundColor: kShrineAltYellow,
            child:Icon(FontAwesomeIcons.rocket), ),

      ),




    /*  FancyButton(onPressed: (){

        if(_subjectController.text.isNotEmpty && _subjectController.text !=null){

          updateSubjectCode(_subjectController.text);

        }else{
            final snackBar = SnackBar(content: Text("Please enter the subject code to continue"),);
            Scaffold.of(context).showSnackBar(snackBar);
        }


        /* Navigator.push(context, MaterialPageRoute(
            builder: (context)=> SectionList(
              course: widget.course,
              lecturer: _lecturerController.text,
              survey: asurvey,
            )
        ));*/
      }), */

    );//scaffold
  }
}