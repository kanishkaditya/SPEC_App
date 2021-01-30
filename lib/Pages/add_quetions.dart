import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class add_quary extends StatefulWidget {
  add_quary({Key key}) : super(key: key);

  @override
  _add_quaryState createState() => _add_quaryState();
}

class _add_quaryState extends State<add_quary> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Type your doubt here'),
          controller: controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send_outlined),
        onPressed: () {
          Firestore.instance.collection('questions').document().setData({
            'query': controller.text,
          });
        },
      ),
    );
  }
}
