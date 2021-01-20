import 'package:flutter/material.dart';
import 'package:spec_app/Components/result_list_renderer.dart';

class ResultTopCard extends StatefulWidget
{
  String data;
  int index;
  ResultTopCard(this.data,this.index);
  @override
  ResultTopCardState createState()=>ResultTopCardState();
}
class ResultTopCardState extends State<ResultTopCard>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children:[
          Hero(tag:widget.data,child: Text(widget.data,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)),
          SizedBox(height: 15,),
          Text(s.branch,style:TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
          SizedBox(height:15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('CGPI ',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600) ,),
              Text(s.summary[widget.index]['cgpi'].toString(),style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600) ,),
            ],),
          SizedBox(height:15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('SGPI ',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600) ,),
                  Text(s.summary[widget.index]['sgpi'].toString(),style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600) ,),
                ],
              ),
        ]
          ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        color:Colors.transparent
      ),
    );

  }

}