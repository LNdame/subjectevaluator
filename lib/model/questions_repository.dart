import 'question.dart';

class QuestionRepository{
  static List<Question> loadQuestions(QuestionSection questionSection){

    const allQuestions =<Question>[
      //section 1
      Question(
          id: 0,
          q_number: 1,
          questionDesc:"Encourages me to tackle the learning experience.",
          questionType: QuestionType.multi,
         questionSection: QuestionSection.one,
         options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 1,
        q_number: 2,
        questionDesc:"Is enthusiastic about teaching the subject and shows it.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 2,
        q_number: 3,
        questionDesc:"Creates learning experiences where I feel free to participate and express my opinions",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 3,
        q_number: 4,
        questionDesc:"Gives me an overall view of the module by providing a clear outline at the beginning.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 4,
        q_number: 5,
        questionDesc:"Explains the purpose of the subject clearly.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 5,
        q_number: 6,
        questionDesc:"Explains the outcomes of individual lectures.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 6,
        q_number: 7,
        questionDesc:"Plans and prepares lectures thoroughly.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),

      Question(
        id: 7,
        q_number: 8,
        questionDesc:"Plans and prepares practical projects thoroughly.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 8,
        q_number: 9,
        questionDesc:"Encourages me to tackle my learning creatively.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 9,
        q_number: 10,
        questionDesc:"Encourages me to think for myself.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 10,
        q_number: 11,
        questionDesc:"Presents stimulating lectures from which I learn.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 11,
        q_number: 12,
        questionDesc:"Chooses topics for assignments/projects which are relevant and clear.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 12,
        q_number: 13,
        questionDesc:"Sets practicals which make sense to me.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),

      Question(
        id: 13,
        q_number: 14,
        questionDesc:"Creates enough opportunities for self-study in his/her subject.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 14,
        q_number: 15,
        questionDesc:"Cares whether I learn something new during his/her lectures.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 15,
        q_number: 16,
        questionDesc:"Assesses tests fairly.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 16,
        q_number: 17,
        questionDesc:"Explains the outcomes of individual projects and assignments.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 17,
        q_number: 18,
        questionDesc:"Assesses projects fairly.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 18,
        q_number: 19,
        questionDesc:"Gives feedback on tests, projects, assignments etc. that I learn from.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 19,
        q_number: 20,
        questionDesc:"Is punctual for classes.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 20,
        q_number: 21,
        questionDesc:"Is available for answering my questions.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 21,
        q_number: 22,
        questionDesc:"Uses a level of language that I can understand.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.one,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 22,
        q_number: 23,
        questionDesc:"Theory lectures",
        questionType: QuestionType.liker,
        questionSection: QuestionSection.one,
        options:<String>["80-100%","70-79%","60-69%","50-59%","0-49%"],
      ),
      Question(
        id: 23,
        q_number: 24,
        questionDesc:"Practicals/Projects",
        questionType: QuestionType.liker,
        questionSection: QuestionSection.one,
        options:<String>["80-100%","70-79%","60-69%","50-59%","0-49%"],
      ),

      //section 2
      Question(
        id: 24,
        q_number: 25,
        questionDesc:"Treats me with respect.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.two,
        options:<String>["Always","Usually","Seldom","Never"],
      ),



      Question(
        id: 25,
        q_number: 26,
        questionDesc:"Acknowledges me as an individual",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.two,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 26,
        q_number: 27,
        questionDesc:"Is easy to talk to and approachable.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.two,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      //section 3
      Question(
        id: 27,
        q_number: 28,
        questionDesc:"The latest developments in this subject are explained to us.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),

      Question(
        id: 28,
        q_number: 29,
        questionDesc:"The way subject content can be applied in the job situation is indicated",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 29,
        q_number: 30,
        questionDesc:"My study guides help me to learn.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 30,
        q_number: 31,
        questionDesc:"Useful study materials are provided.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 31,
        q_number: 32,
        questionDesc:"The links between topics in subjects are clearly indicated.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 32,
        q_number: 33,
        questionDesc:"The subject content is set out logically",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 33,
        q_number: 34,
        questionDesc:"The volume of work is manageable.",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 34,
        q_number: 35,
        questionDesc:"The level of the subject content is stimulating",
        questionType: QuestionType.multi,
        questionSection: QuestionSection.three,
        options:<String>["Always","Usually","Seldom","Never"],
      ),

      //section 4
      Question(
        id: 35,
        q_number: 36,
        questionDesc:"What are the positive aspects of the subject and content?",
        questionType: QuestionType.open,
        questionSection: QuestionSection.four,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 36,
        q_number: 37,
        questionDesc:"What are the positive aspects of the teaching?",
        questionType: QuestionType.open,
        questionSection: QuestionSection.four,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 37,
        q_number: 38,
        questionDesc:"Suggest ways to improve lectures (what helps you learn effectively in this subject/module)?",
        questionType: QuestionType.open,
        questionSection: QuestionSection.four,
        options:<String>["Always","Usually","Seldom","Never"],
      ),
      Question(
        id: 38,
        q_number: 39,
        questionDesc:"Suggest ways to improve practicals/projects",
        questionType: QuestionType.open,
        questionSection: QuestionSection.four,
        options:<String>["Always","Usually","Seldom","Never"],
      ),



    ];

    if(questionSection== QuestionType.all){
      return allQuestions;
    }else{
      return allQuestions.where((Question q){
        return q.questionSection ==questionSection;
      }
      ).toList();
    }

  }
}