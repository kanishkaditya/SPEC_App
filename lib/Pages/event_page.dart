import 'dart:math';

import 'package:flutter/material.dart';
import 'file:///C:/Users/kanishkaditya/AndroidStudioProjects/spec_app/lib/Cards/Card.dart';
import '../Objects/Event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Event_Page extends StatefulWidget {
  const Event_Page({
    Key key,
  }) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Event_Page> with AutomaticKeepAliveClientMixin {
   List<Event>events=[];

   //final Color _backgroundColor = Color(0xFFf0f0f0);
   final ScrollController _scrollController = ScrollController();
   final List<int> _openCards = [];
  @override
    Widget build(BuildContext context){
      super.build(context);
    return Container(
      child:Flex(
        direction: Axis.vertical,
        children:<Widget>[ 
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:Firestore.instance.collection('Events').snapshots(),
            builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>querySnapshot)
        {
            if(querySnapshot.hasError)
            return Text("Some Error");
            if(querySnapshot.connectionState==ConnectionState.waiting){
              return CircularProgressIndicator();}
            else {
              final list=querySnapshot.data.documents;
              list.forEach((element) {
                events.add(Event(element.data));
              });
                  return ListView.builder(
                  itemCount: events.length,
                  physics:BouncingScrollPhysics(),
                  itemBuilder: (context,index)
                    {
                      return Cards(
                        event: events[index],
                        onClick: () => _handleclickedCard(index),
                      );
                    },
                  );
              }
        }
    ),
          ),
        ],
      )
    );

  }

  @override
  //TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

   bool _handleclickedCard(int clickedCard) {
     // Scroll to ticket position
     // Add or remove the item of the list of open tickets
     _openCards.contains(clickedCard) ? _openCards.remove(clickedCard) : _openCards.add(clickedCard);

     // Calculate heights of the open and closed elements before the clicked item
     double openTicketsOffset = Cards.nominalOpenHeight * _getOpenTicketsBefore(clickedCard);
     double closedTicketsOffset = Cards.nominalClosedHeight * (clickedCard - _getOpenTicketsBefore(clickedCard));

     double offset = openTicketsOffset + closedTicketsOffset - (Cards.nominalClosedHeight * .5);

     // Scroll to the clicked element
     if(_scrollController.hasClients)
     _scrollController.animateTo(max(0, offset), duration: Duration(seconds: 1), curve: Interval(.25, 1, curve: Curves.easeOutQuad));
     // Return true to stop the notification propagation
     return true;
   }

   _getOpenTicketsBefore(int ticketIndex) {
     // Search all indexes that are smaller to the current index in the list of indexes of open tickets
     return _openCards.where((int index) => index < ticketIndex).length;
   }

}
