import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spec_app/Objects/ManualEvent.dart';
import 'package:spec_app/Pages/Home.dart';
import 'package:spec_app/main.dart';
import 'package:uuid/uuid.dart';

class addEvents extends StatefulWidget {
  @override
  _addEventsState createState() => _addEventsState();
}

class _addEventsState extends State<addEvents> {


  List<File> files;
  String uid = Uuid().v4().toString();

  DateTime lastDate;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _summary = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Add Events'),
          TextFormField(
            controller: _title,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'assets/fonts/Montserrat-Medium.ttf'
            ),
            decoration: InputDecoration(
                labelText:"Tittle",
                icon: Icon(Icons.title),
            ),
          ),
          InkWell(
            child: Icon(
            Icons.calendar_today_rounded,
          ),onTap: ()async{
              lastDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), // Refer step 1
              firstDate: DateTime(2000),
            lastDate: DateTime(2025),
            );

          },
          ),
          TextFormField(
            controller: _summary,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'assets/fonts/Montserrat-Medium.ttf'
            ),
            decoration: InputDecoration(
              labelText:"Description",
              icon: Icon(Icons.description),
            ),
          ),
          InkWell(
            child: Icon(
              Icons.upload_file
            ),onTap: ()async{
            FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true , type: FileType.custom,
              allowedExtensions: ['jpg', 'pdf', 'doc'],);

            if(result != null) {

              files = result.paths.map((path) => File(path)).toList();

            }
            else {
              // User canceled the picker
            }

          },
          ),
          FloatingActionButton(

            onPressed: () async {
              List<String> Doc_url = List();
              String title = _title.value.text;
              String description = _summary.value.text;
              if(files!=null)
               for(int i = 0; i <files.length;i++){

                StorageReference ref = FirebaseStorage().ref().child(
                    '$uid/doc$i');
                StorageUploadTask uploadTask = ref.putFile(files[i]);
                StorageTaskSnapshot snapshot = await uploadTask.onComplete;
                Doc_url.add( await snapshot.ref.getDownloadURL());
              }
              comingEvents.add(ManualEvent(name: title,Doc_url: Doc_url,lastDate: lastDate,summary: description));
              await Firestore.instance.collection("ManualEvents").document().setData({
                 "name" : title,
                 "summary" : description,
                 "lastdate" : lastDate,
                 "urls" : Doc_url,
               }).whenComplete(() => Navigator.pop(context));
            },
          )

        ],
      ),
    );
  }
}
