import 'package:slimy_card/slimy_card.dart';
import 'package:spec_app/Cards/result_bottom_card.dart';
import 'package:spec_app/Cards/result_top_card.dart';
import 'package:spec_app/Objects/Student.dart';
import 'package:flutter/material.dart';
Student s;
class ResultListRenderer extends StatefulWidget {
  final String data;
  final int index;
  final Function(String,int) onTap;
  final double hzPadding;

  const ResultListRenderer({Key key, this.data,this.onTap, this.hzPadding = 0,this.index}) : super(key: key);

  @override
  _ResultListRendererState createState() => _ResultListRendererState();
}

class _ResultListRendererState extends State<ResultListRenderer> {

  @override
  Widget build(BuildContext context) {
    double leftPadding = 0 ;
    double rightPadding =widget.hzPadding;
    double vtPadding = 24;

          return Stack(
            children: [
              Container(
              padding: EdgeInsets.only(top: vtPadding, bottom: vtPadding, left: leftPadding, right: rightPadding),
              alignment:Alignment.centerRight,
              child: SlimyCard(topCardHeight: 200,borderRadius:10,color:Colors.orange,bottomCardHeight:150,bottomCardWidget:ResultBottomCard(widget.index),topCardWidget: ResultTopCard(widget.data+' sem',widget.index))
              ),
              Padding(
                padding: EdgeInsets.only(left:20,top:35),
                child: InkWell(
                    child:Container(
                      width: 50,
                      height: 50,
                      child:Icon(Icons.arrow_drop_up_outlined),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25),boxShadow:[BoxShadow(blurRadius: 150,spreadRadius: 1)]),
                    ),
                  onTap:(){_handleTap();},
                ),
              ),
            ],
          );
  }

  void _handleTap() {
    if(widget.onTap != null){
      widget.onTap(widget.data+' sem',widget.index);
    }
  }

}
