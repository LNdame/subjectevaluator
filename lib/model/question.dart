import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
enum QuestionType{all,multi, liker,open}
enum QuestionSection{all, one,two,three,four}
class Question{

  final int id;
  final int q_number;
  final String questionDesc;
  final QuestionType questionType;
  final QuestionSection questionSection;
  final List<String> options;


  const Question({
       this.id,
      this.q_number,
      this.questionDesc,
      this.questionType,
    this.questionSection,
      this.options
      }) : assert(id !=null),
           assert(q_number !=null),
           assert(questionDesc !=null),
           assert(questionType !=null),
           assert(questionSection !=null),
           assert(options !=null);


  @override
  String toString() =>"$questionDesc";


}