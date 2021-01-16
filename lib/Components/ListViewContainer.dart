import 'package:flutter/material.dart';
import 'package:spec_app/Components/List.dart';


class ListViewContent extends StatefulWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;

  ListViewContent({
    this.listSlideAnimation,
    this.listSlidePosition,
    this.listTileWidth,
  });

  @override
  _ListViewContentState createState() => _ListViewContentState();
}

class _ListViewContentState extends State<ListViewContent> {

  @override
  Widget build(BuildContext context) {
    return (new Stack(
      alignment: widget.listSlideAnimation.value,
      children: <Widget>[
        new ListData(
            margin: widget.listSlidePosition.value * 7.5,
            width: widget.listTileWidth.value,
            title: "Breakfast with Harry",
            subtitle: "9 - 10am ",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 6.5,
            width: widget.listTileWidth.value,
            title: "Meet Pheobe ",
            subtitle: "12 - 1pm  Meeting",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 5.5,
            width: widget.listTileWidth.value,
            title: "Lunch with Janet and friends",
            subtitle: "2 - 3pm ",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 4.5,
            width: widget.listTileWidth.value,
            title: "Catch up with Tom",
            subtitle: "5 - 6pm  Hangouts",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 3.5,
            width: widget.listTileWidth.value,
            title: "Party at Hard Rock",
            subtitle: "8 - 12 Pub and Restaurant",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 2.5,
            width: widget.listTileWidth.value,
            title: "Breakfast with Harry",
            subtitle: "9 - 10am ",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 1.5,
            width: widget.listTileWidth.value,
            title: "Breakfast with Harry",
            subtitle: "9 - 10am ",
            image: null),
        new ListData(
            margin: widget.listSlidePosition.value * 0.5,
            width: widget.listTileWidth.value,
            title: "Breakfast with Harry",
            subtitle: "9 - 10am ",
            image: null),

      ],
    ));
  }

}
