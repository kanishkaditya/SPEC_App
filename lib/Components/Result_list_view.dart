import 'dart:convert';
import 'package:http/http.dart';
import 'package:spec_app/Components/result_list_renderer.dart';
import 'package:spec_app/Objects/Student.dart';
import 'package:spec_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

List sems=['First','Second','Third','Fourth','Fifth','Sixth','Seventh','Eighth','Twelveth'];

class ResultListView extends StatefulWidget {
  static const route = "ResultListView";

  final void Function(double) onScrolled;
  final void Function(String,int) onItemTap;

  const ResultListView({Key key, this.onScrolled, this.onItemTap}) : super(key: key);

  @override
  _ResultListViewState createState() => _ResultListViewState();
}

class _ResultListViewState extends State<ResultListView> {
  double _prevScrollPos = 0;
  double _scrollVel = 0;

  @override
  Widget build(BuildContext context) {
    //Build list using data
    return FutureBuilder(
        future: http.get("https://nithp.herokuapp.com/api/result/student/$rollno"),
        builder:(context,snapshot) {
          if (snapshot.hasData) {
            Response r = snapshot.data;
            s = Student(json.decode(r.body));
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Stack(
                children: [
                  //Scrolling list, draw this first so it's under the other content
                  _buildScrollingList(),
                  //Cover the list with black gradients on top & bottom
                   //  _buildGradientOverlay(),
                  //Top left text
                     _buildHeaderText(),
                ],
              ),
            );
          }
          else return Center(child: CircularProgressIndicator());
        });
  }

  Container _buildScrollingList() {
    //Seed our random number generator, so the padding is always consistent between runs (Designers are picky!)
    return Container(
      padding: EdgeInsets.only(left: 15),
      //Wrap list in a NotificationListener, so we can detect scroll updates
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: s.summary.length,
          //Add some extra padding to the top & bottom of the list
          padding: EdgeInsets.only(top: 300, bottom: 200),
          itemBuilder: (context, index) {
            return ResultListRenderer(
              //Re-dispatch our tap event to anyone who is listening
              onTap: widget.onItemTap,
              data: sems[index],
              hzPadding: 20,
              index: index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Container(
      padding: EdgeInsets.only(top: 30,left: 15),
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Result",
            style: TextStyle(color: Colors.black, fontSize: 28, height: 1.05),
          ),
          SizedBox(height: 15,),
          Text(
            user.displayName,
            style: TextStyle(color: Colors.black54, fontSize: 25, height: 1.05),
          ),
          SizedBox(height: 15,),
          Text(
            rollno,
            style: TextStyle(color: Colors.black38, fontSize: 25, height: 1.05),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.only(left: 250),
            child: Column(
            children:[Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('CGPI ',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600) ,),
                Text(s.summary[s.summary.length-1]['cgpi'].toString(),style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600) ,),
              ],),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('SGPI ',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600) ,),
                Text(s.summary[s.summary.length-1]['sgpi'].toString(),style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600) ,),
              ],
            ),]
            ),
          )
        ],
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    //Determine scrollVelocity and dispatch it to any listeners
    _scrollVel = notification.metrics.pixels - _prevScrollPos;
    if (widget.onScrolled != null) {
      widget.onScrolled(_scrollVel);
    }
    //print(notification.metrics.pixels - _prevScroll);
    _prevScrollPos = notification.metrics.pixels;
    //Return true to cancel the notification bubbling, we've handled it here.
    return true;
  }
}
