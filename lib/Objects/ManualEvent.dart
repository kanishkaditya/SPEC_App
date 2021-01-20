import 'package:uuid/uuid.dart';

class ManualEvent{
  String name;
  String summary;
  DateTime lastDate;
  List<String> Doc_url;


  ManualEvent({this.name , this.summary , this.lastDate , this.Doc_url});
}