import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spec_app/Cards/EventCard.dart';
import 'package:spec_app/Cards/event_detail.dart';
import 'package:spec_app/Cards/event_summary.dart';
import 'package:spec_app/Objects/Event.dart';

import 'folding_card.dart';


class Cards extends StatefulWidget {
  static const double nominalOpenHeight = 400;
  static const double nominalClosedHeight = 160;
  final Event event;
  final Function onClick;

  const Cards({Key key, @required this.event, @required this.onClick}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CardState();
}

class _CardState extends State<Cards> {
  EventCard frontCard;
  EventCard topCard;
  EventDetails middleCard;
  EventSummary bottomCard;
  bool _isOpen;

  Widget get backCard =>
      Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Color(0xffdce6ef)));

  @override
  void initState() {
    super.initState();
    _isOpen = false;
    frontCard =EventCard(event:widget.event,theme:SummaryTheme.dark);
    middleCard = EventDetails(widget.event);
    bottomCard = EventSummary(e:widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return FoldingCard(entries: _getEntries(), isOpen: _isOpen, onClick: _handleOnTap);
  }

  List<FoldEvent> _getEntries() {
    return [
      FoldEvent(height: 160.0, front: topCard),
      FoldEvent(height: 160.0, front: middleCard, back: frontCard),
      FoldEvent(height: 80.0, front: bottomCard, back: backCard)
    ];
  }

  void _handleOnTap() {
    widget.onClick();
    setState(() {
      _isOpen = !_isOpen;
      topCard = EventCard(event: widget.event, isOpen: _isOpen);
    });
  }
}
