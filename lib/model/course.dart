

class Course {
  final String Id;
  final String name;

  Course({this.Id, this.name}):assert(Id !=null), assert(name!=null);





  @override
  String toString() =>"$name";

}