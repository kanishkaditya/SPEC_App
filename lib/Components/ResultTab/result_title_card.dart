import 'package:flutter/material.dart';

class ResultTitleCard extends StatelessWidget {
  final String data;
  final int index;

  const ResultTitleCard({Key key, this.data,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Create paint for our text
    //Need to wrap the title with spaces, to prevent a flicker during the Hero animation. known issue: https://github.com/flutter/flutter/issues/42988
    var titleText = Text("  ${data}  ",
        style: TextStyle(fontSize: 42, height: 1.3));
   // var subTitleText =
     //   Text("${data.subTitle}", style: TextStyle(fontSize: 16, color: color,));

    return Hero(
      tag: "$data",
      //Need to  wrap hero content in a Material so we don't lose text styling while hero is animating. Known issue: https://github.com/flutter/flutter/issues/30647#issuecomment-509712719
      child: Material(
          color: Colors.transparent,
          child: titleText
    )
    );
  }
}
