import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spec_app/Objects/Event.dart';



enum SummaryTheme { dark, light }

class EventCard extends StatelessWidget {
  final Event event;
  final SummaryTheme theme;
  final bool isOpen;

  const EventCard({Key key, this.event, this.theme = SummaryTheme.light, this.isOpen = false}):super(key: key);

  Color get mainTextColor {
    Color textColor;
    if (theme == SummaryTheme.dark) textColor = Colors.white;
    if (theme == SummaryTheme.light) textColor = Color(0xFF083e64);
    return textColor;
  }

  Color get secondaryTextColor {
    Color textColor;
    if (theme == SummaryTheme.dark) textColor = Color(0xff61849c);
    if (theme == SummaryTheme.light) textColor = Color(0xFF838383);
    return textColor;
  }

  Color get separatorColor {
    Color color;
    if (theme == SummaryTheme.light) color = Color(0xffeaeaea);
    if (theme == SummaryTheme.dark) color = Color(0xff396583);
    return color;
  }

  TextStyle get bodyTextStyle => TextStyle(color: mainTextColor, fontSize: 13, fontFamily: 'Oswald');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildLogoHeader(),
            _buildSeparationLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child:Align(alignment: Alignment.center, child: _buildCardHeader(context)),
            ),
          ],
        ),
      ),
    );
  }

  _getBackgroundDecoration() {
    if (theme == SummaryTheme.light)
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      );
    if (theme == SummaryTheme.dark)
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(image: AssetImage('assets/Image/bg_blue.png',), fit: BoxFit.cover),
      );
  }

  _buildLogoHeader() {
    if (theme == SummaryTheme.light)
      return Text(event.name.toUpperCase(),
          style: TextStyle(
            color: mainTextColor,
            fontFamily: 'OpenSans',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,));
    if (theme == SummaryTheme.dark)
      return Text(event.name.toUpperCase(),
          style: TextStyle(
            color: mainTextColor,
            fontFamily: 'OpenSans',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,));
  }

  Widget _buildSeparationLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: separatorColor,
    );
  }

  Widget _buildCardHeader(context) {

    return Container(
        height: 80,
        width: 80,
        child:FittedBox(
          child:Image.network(
            event.image_url,
            loadingBuilder: (context,child,loadingProgress)
            {
              if(loadingProgress==null)
                return child;
              return Center(child:CircularProgressIndicator(
                value:loadingProgress.expectedTotalBytes!=null?loadingProgress
                    .cumulativeBytesLoaded/loadingProgress.expectedTotalBytes:null,
              ),
                widthFactor: 2,
                heightFactor: 2,);
            }
            ,),
          fit:BoxFit.fill,
        ));
  }
}
