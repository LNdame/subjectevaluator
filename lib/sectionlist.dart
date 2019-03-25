import 'package:flutter/material.dart';
import 'textstyle.dart';
import 'sectionone.dart';
import 'sectiontwo.dart';
import 'sectionthree.dart';
import 'sectionfour.dart';
import 'colors.dart';
import 'package:subjectevaluator/model/course.dart';
import 'package:subjectevaluator/model/survey.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'textstyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SectionList extends StatefulWidget{

    final Course course;
    final String lecturer;
    final Survey survey;


    SectionList({Key key,this.course, this.lecturer, this.survey}):assert(course!=null),
          assert(lecturer!=null),
          super(key:key);

    @override
  _SectionListState createState() {
    return new _SectionListState();
  }
}

class _SectionListState extends State<SectionList> with WidgetsBindingObserver {

  bool sectOneCompleted = false;
  bool sectTwoCompleted = false;
  bool sectThreeCompleted = false;
  bool sectFourCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSurveyData();

    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    super.didChangeAppLifecycleState(state);


  }


  void getSurveyData(){

    int element_count=0;
    Firestore.instance.collection('surveys').document(widget.survey.Id).get().then(
            (DocumentSnapshot docSnap){


              sectOneCompleted = docSnap.data['section_one_completed'];
              sectTwoCompleted = docSnap.data['section_two_completed'];
              sectThreeCompleted = docSnap.data['section_three_completed'];
              sectFourCompleted =docSnap.data['section_four_completed'];



          print(docSnap.documentID);
          print(docSnap.data['lecturer_name']);
          print(element_count);
        });


  }//survey data


  Widget _buildSectionItems(Color color,IconData icon, String title, String titledesc, int number, int sectionNumber, BuildContext context ){
    return GestureDetector(
      child: Container(

        color: color,
        height: 300.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  icon,
                  size: 90.0,
                  color: Colors.white,
                ),
              ),
              Text(title,
              style: Style.headerstyle),
              SizedBox(height: 5.0,),
              Text(titledesc,
                  style: Style.headerstyle),
              SizedBox(height: 5.0,),
              Text("This section has $number questions",
                style: Style.baseTextStyle,

              )

            ],//children
          ),//column
        ),//center
      ),//container
      onTap: () async{

        _gotoSection(sectionNumber,  context);
        /*
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> SectionOne()

          )
        );*/
      },
    );//gd
  }





  void _gotoSection(int sectionNumber, BuildContext aContext ){

    switch(sectionNumber){
      case 1:
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SectionOne(survey: widget.survey, course: widget.course, lecturer: widget.lecturer,))); break;
      case 2:
        if(!sectOneCompleted){ final snackbar = SnackBar(content: Text("Please complete Section ${sectionNumber -1} before attempting this section",style: TextStyle(color: kShrineErrorRed) ,),);
        Scaffold.of(aContext).showSnackBar(snackbar);
        return;}else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SectionTwo(survey: widget.survey, course: widget.course, lecturer: widget.lecturer,)));} break;
      case 3:
        if(!sectTwoCompleted) {final snackbar = SnackBar(content: Text("Please complete Section ${sectionNumber -1} before attempting this section",style: TextStyle(color: kShrineErrorRed) ,),);
        Scaffold.of(aContext).showSnackBar(snackbar);
        return;}else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SectionThree(survey: widget.survey, course: widget.course, lecturer: widget.lecturer,)));} break;
      case 4:
        if(!sectThreeCompleted) {final snackbar = SnackBar(content: Text("Please complete Section ${sectionNumber -1} before attempting this section",style: TextStyle(color: kShrineErrorRed) ,),);
        Scaffold.of(aContext).showSnackBar(snackbar);
        return;}else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SectionFour(survey: widget.survey, course: widget.course, lecturer: widget.lecturer,))); } break;
    }


  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Sections'),
      ),

      body: Builder(builder: (context)=>

      SafeArea(child: ListView(
        children: <Widget>[
          Container(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[



                //lecturer row
                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.chalkboardTeacher, size: 32.0,),
                    SizedBox(width: 18.0),
                    Text("Lecturer: ${widget.lecturer}",
                      style: TextStyle(
                        fontSize: 20.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w600,
                      ),

                    ),
                  ],

                ),
                   SizedBox(height: 15.0,),
                    //course row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(FontAwesomeIcons.codepen, size: 26.0, ),
                        SizedBox(width: 18.0),
                        Expanded(
                          child: Text("Faculty: ${widget.course.name}",
                            style: TextStyle(
                              fontSize: 18.0, fontFamily: 'Rubrik', fontWeight: FontWeight.w400,
                            ),

                          ),
                        ),
                      ],

                    ),


                  ],//widget
                ),//column


              ),//padding
            ),//container

          _buildSectionItems(Color(0xFFFFB300) ,  FontAwesomeIcons.chalkboard, "Section 1","Lecturer and Teaching", 24,1, context),
          _buildSectionItems(Color(0xFF455A64),  FontAwesomeIcons.drawPolygon, "Section 2","Lecturer and Student Relationships", 3,2,context),
          _buildSectionItems(Color(0xFF00695C),  FontAwesomeIcons.book, "Section 3","Subject Content", 8,3,context),
          _buildSectionItems(Color(0xFFD84315),  FontAwesomeIcons.clone, "Section 4","General", 4,4,context),
        ],
      ),//listview
      ) ),//safearea
    );//scaffold
  }


}