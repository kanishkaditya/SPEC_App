import 'package:flutter/material.dart';
import 'package:spec_app/Cards/User_Home_Pane.dart';
class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('SPEC',style:TextStyle(color:Colors.black)),
      ),
      body:Container(
        child: ListView(
          padding:EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
          children:<Widget>[
            detail_pane.vertical(),
          ]
    ),
      )
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}