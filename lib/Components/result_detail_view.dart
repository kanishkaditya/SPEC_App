
import 'package:flutter/material.dart';
import 'package:spec_app/Components/result_list_renderer.dart';
import 'package:spec_app/Components/result_title_card.dart';
import 'package:spec_app/Objects/Result.dart';

class ResultDetailView extends StatefulWidget {
  static const route = "ResultDetailView";

  final String data;
  final int index;
  final int contentDelay;
  final Function onBackTap;

  const ResultDetailView({Key key, this.data,this.contentDelay = 1000, @required this.onBackTap,this.index}) : super(key: key);

  @override
  _ResultDetailViewState createState() => _ResultDetailViewState();
}

class _ResultDetailViewState extends State<ResultDetailView> with SingleTickerProviderStateMixin {
  AnimationController _animController;


  @override
  void initState() {
    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.contentDelay))
      ..addListener(() {
        setState(() {});
      });
    _animController.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Result>l = List();
    for (int i = 0; i < s.result.length; i++){
      if(s.result[i].sem==widget.index)
        {
          l.add(s.result[i]);
        }
    }
    return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 24),
        child: Column(
          children: <Widget>[
            ResultTitleCard(
              data: widget.data,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              splashColor: Colors.white24,
              color: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40), side: BorderSide(color: Color(0xffc9c9c9))),
              //Dispatch our tap event to the parent of this widget, and let them handle it.
              onPressed: () => widget.onBackTap(),
              child: Text("Return to List", style: TextStyle( color: Colors.white)),
            ),
            SizedBox(
              height: 36,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: l.length,
                itemBuilder: (BuildContext context,int index){
                return ListTile(title:Text(l[index].subject),trailing: Text(l[index].grade),);
                }
            ),
          ],
        ));
  }
}
