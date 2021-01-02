import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spec_app/main.dart';

class detail_pane extends StatelessWidget {

  final bool horizontal;

  detail_pane({this.horizontal = true});

  detail_pane.vertical(): horizontal = false;
   @override
  Widget build(BuildContext context) {
    final planetThumbnail = Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child:CircleAvatar(
        backgroundImage: NetworkImage(user.photoUrl),
        radius:50
      )
    );

    final planetCardContent = Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 10.0),
          Text(user.displayName,style: TextStyle(fontFamily:'OpenSans',color: Colors.white,
             fontWeight: FontWeight.bold),),
          Container(height: 4.0),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: Color(0xff00c6ff)
          ),
        ],
      ),
    );

    final planetCard = Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? new EdgeInsets.only(left: 46.0)
       : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
       color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3), // changes position of shadow
    ),
     ],
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      );
  }
}