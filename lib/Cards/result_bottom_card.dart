import 'package:flutter/material.dart';
import 'package:spec_app/Components/ResultTab/result_list_renderer.dart';

class ResultBottomCard extends StatefulWidget
{
  int index;
  ResultBottomCard(this.index);
  @override
  ResultBottomCardState createState()=>ResultBottomCardState();
}
class ResultBottomCardState extends State<ResultBottomCard>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('CGPI total ',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                Text(s.summary[widget.index]['cgpi_total'].toString(),style:TextStyle(fontSize: 15,fontWeight: FontWeight.w500) ,),
              ],),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('SGPI total ',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500) ,),
                Text(s.summary[widget.index]['sgpi_total'].toString(),style:TextStyle(fontSize: 15,fontWeight: FontWeight.w500) ,),
              ],),
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