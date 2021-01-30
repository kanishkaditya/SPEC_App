import 'package:flutter/material.dart';
import 'package:spec_app/Pages/add_quetions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mentor_chat extends StatefulWidget {
  Mentor_chat({Key key}) : super(key: key);

  @override
  _Mentor_chatState createState() => _Mentor_chatState();
}

class _Mentor_chatState extends State<Mentor_chat> {
  ScrollController scroller = ScrollController();
  TextEditingController controller = TextEditingController();
  TextEditingController answer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white54,
          title: Text(
            'Spec spot',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_quary()));
                }),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body:
            // SizedBox(
            //   height: 5,
            // ),
            // Center(
            //   child: Container(
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: TextFormField(
            //         decoration: InputDecoration(labelText: 'Type your doubt here'),
            //         controller: controller,
            //       ),
            //     ),
            //     alignment: Alignment.bottomCenter,
            //     color: Colors.white,
            //     width: MediaQuery.of(context).size.width * 1,
            //     //height: MediaQuery.of(context).size.height * 0.15,
            //   ),
            // ),
            StreamBuilder(
                stream: Firestore.instance.collection('questions').snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var docList = snapshot.data.documents;
                    print(docList.length);
                    return Card(
                      child: ListView.builder(
                          controller: scroller,
                          itemCount: docList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 15),
                              child: ListTile(
                                //onTap: ,
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 7,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          docList[index]['time']
                                              .toString()
                                              .substring(0, 9),
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      docList[index]['query'],
                                      style: TextStyle(fontSize: 20),
                                    ),

                                    TextField(
                                      controller: answer,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.send),
                                          labelText: 'post your answers'),
                                    ),
                                    // IconButton(
                                    //   icon: Icon(Icons.send),
                                    //   onPressed: () {},
                                    // ),
                                  ],
                                ),
                                //         child: Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     CircleAvatar(
                                //       backgroundColor: Colors.blue,
                                //       radius: 30,
                                //     ),

                                //   ],
                                // )
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                }));
  }
}
