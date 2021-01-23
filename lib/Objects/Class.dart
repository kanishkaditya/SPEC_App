import 'package:flutter/material.dart';

class Class {
  String title;
  String subtitle;
  String teacher;
  DecorationImage image;
  bool isToday;
  Class({this.subtitle, this.title, this.image,this.isToday,this.teacher});

  @override
  bool operator ==(Object other) {
    return other is Class &&this.title==other.title&&other.subtitle==this.subtitle;
  }
}
