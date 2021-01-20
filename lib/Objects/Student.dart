import 'dart:convert';

import 'package:spec_app/Objects/Result.dart';
class Student {
  String branch;
  double cgpi;
  String rollNo;
  double sgpi;
  List<Map<String,dynamic>>summary=List();
  String name;
  Map<String, Map<String,int>>rank=Map();
  List<Result> result=List();

  Student(dynamic json)
  {
    branch=json['branch'];
    cgpi=json['cgpi'];
    sgpi=json['sgpi'];
    rank['class']=Map.from(json['rank']['class']);
    rank['college']=Map.from(json['rank']['college']);
    rank['year']=Map.from(json['rank']['year']);
    rollNo=json['roll'];
    name=json['name'];
    json['summary'].forEach((element){
      summary.add(Map.from(element));
    });
    json['result'].forEach((element){
      result.add(Result(element));
  });
  }

}