import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spec_app/Objects/Event.dart';

class EventSummary extends StatefulWidget {
  Event e;

  EventSummary({this.e});


  @override
  _EventSummaryState createState() => _EventSummaryState(e);
}

class _EventSummaryState extends State<EventSummary> {
  Event event;
  _EventSummaryState(this.event);
  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0,top: 15.0),
        child:Text(event.summary),
      ));
}
