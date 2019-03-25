import 'package:flutter/material.dart';
import 'package:subjectevaluator/model/question.dart';
import 'package:subjectevaluator/model/questions_repository.dart';
import 'package:subjectevaluator/uiwidget/multi_widget.dart';
import 'package:subjectevaluator/uiwidget/textbutton_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'sectionlist.dart';
import 'colors.dart';
import 'sectiontwo.dart';
import 'package:subjectevaluator/model/course.dart';
import 'package:subjectevaluator/model/survey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class SectionOne extends StatefulWidget{

  final Course course;
  final String lecturer;
  final Survey survey;

  SectionOne({Key key,this.course, this.lecturer, this.survey}):assert(course!=null),
        assert(lecturer!=null),
        super(key:key);


  @override
  _SectionOneState createState() => new _SectionOneState();

}

class _SectionOneState extends State<SectionOne> {

  @override
  void initState() {

      getSurveyData();



  }


  void getSurveyData(){

        int element_count=0;
        Firestore.instance.collection('surveys').document(widget.survey.Id).get().then(
           (DocumentSnapshot docSnap){

             if(docSnap.data['section_one_loaded']==false){
               List<Question> questions =QuestionRepository.loadQuestions(QuestionSection.one);


                 Firestore.instance.runTransaction((Transaction transaction) async{
                   CollectionReference reference = Firestore.instance.collection('answers');

                   questions.forEach((element) async{

                   await reference.add({"answer":"${element.options[0]}",
                     "course_id":"${widget.course.Id}",
                     "question_desc":"${element.questionDesc}",
                     "question_id":element.id,
                     "survey_id":"${widget.survey.Id}",
                     "section_number":1,
                     "edited":false,
                     "options":element.options
                   }).then((reference){
                     element_count++;
                     print(element_count);
                   });
                 });//for each

               });
               //update the section number

               Firestore.instance.runTransaction((Transaction transaction) async{
                 await transaction.update(docSnap.reference, {"section_one_loaded":true});
               });


             }

             print(docSnap.documentID);
             print(docSnap.data['lecturer_name']);
             print(element_count);
           });


  }//survey data


  void updateSection(){
    Firestore.instance.collection('surveys').document(widget.survey.Id).get().then(
            (DocumentSnapshot docSnap){
              Firestore.instance.runTransaction((Transaction transaction) async{
                await transaction.update(docSnap.reference, {"section_one_completed":true});
              });
            });
  }



  Widget headersection = Container(
    padding: EdgeInsets.all(16.0),
    child: Row(
      children: <Widget>[
        Text("1",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        Text("Question Description",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
         )
      ],//children
    ),//row
  );
  List<SizedBox> _buildLayoutCards(BuildContext context){

    List<Question> questions =QuestionRepository.loadQuestions(QuestionSection.one);
    if(questions==null|| questions.isEmpty){
      return const<SizedBox>[];
    }


    final ThemeData themeData = Theme.of(context);

    return questions.map((question){

      return SizedBox(
        height: 222.0,
        child: Card(
          elevation: 2.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderSection(number: question.q_number, desc: question.questionDesc),
              MultiWidget(options:question.options ,),



            ],//children

          ),//column
        )//card ,
      );

    }).toList();


  }

  @override
  Widget build(BuildContext context) {

    String _selectedOption = "yellow";
    // widget.selectOption=["blue","yellow","green"];
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
          title: Text("S1 - Lecturer and Teaching"),

        actions: <Widget>[
         // icon
          IconButton(icon: Icon(FontAwesomeIcons.clone, semanticLabel: 'home',), onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> SectionList(
                  course: widget.course,
                  lecturer: widget.lecturer,
                  survey: widget.survey,
                )
            ));
           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SectionTwo(survey: widget.survey, course: widget.course, lecturer: widget.lecturer,)));

          })
        ],

      ),//app

      body: SafeArea(child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child:  StreamBuilder(
                stream: Firestore.instance.collection('answers').where('survey_id', isEqualTo:widget.survey.Id )
                    .where('section_number', isEqualTo:1 ).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData) return CircularProgressIndicator();

                  return AnswersListView(documents: snapshot.data.documents,);
                })


            /*ListView(
              padding: EdgeInsets.all(12.0),
              children:



              _buildLayoutCards(context),
            ),//listview
          */
          ),//expanded
          Container(
            color: kShrineAltYellow,
            child: Row(
              children: <Widget>[
                //left button
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Text('back'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color:  Theme.of(context).primaryColor ,
                      )),
                  onPressed: () {
                    // TODO:
                    Navigator.of(context).pop();
                  },
                ),//left fb

                //space between button
                Expanded(child: Container(),),

                //right button
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Text('next'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color:  Theme.of(context).primaryColor ,
                      )),
                  onPressed: () {
                    // TODO:
                    updateSection();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SectionTwo(survey: widget.survey, course: widget.course, lecturer: widget.lecturer,)));

                  },
                ),//right fb
              ],
            ),//row
          ),//container


        ],//widget

      )//column




      ),//safe area-body

    );//scaffold
  }
}

class AnswersListView extends StatelessWidget{

  final List<DocumentSnapshot> documents;

  AnswersListView({this.documents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: documents.length,
        itemBuilder: (BuildContext context, int index){
        int qnumber = documents[index].data['question_id'] +1;
        String qDesc = documents[index].data['question_desc'].toString();
        List<String>options = documents[index].data['options'].map<String>((item){
          return item.toString();
        }).toList();

        return SizedBox(
            height: 222.0,
            child: Card(
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderSection(number: qnumber, desc: qDesc),
                  MultiWidget(options:options ,documentSnapshot: documents[index],),



                ],//children

              ),//column
            )//card ,
        );//sized box

        }//item builder

    );
  }


}



class HeaderSection extends StatelessWidget{

  int number;
  String desc;

  HeaderSection({this.number, this.desc});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Text("$number",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          SizedBox(width: 20.0,),

          Expanded(

            child: Text(desc,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              softWrap: true,
            ),
          )

        ],//children
      ),//row

    );
  }

}
