class Result{
  String grade;
  int sem;
  int sub_gp;
  int sub_point;
  String subject;
  String subject_code;

  Result(dynamic json)
  {
    grade=json['grade'];
    sem=json['sem'];
    sub_gp=json['sub_gp'];
    sub_point=json['sub_point'];
    subject=json['subject'];
    subject_code=json['subject_code'];

  }
}