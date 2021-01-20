import 'package:flutter/material.dart';
import 'package:sa_v1_migration/sa_v1_migration.dart';

class Circle extends StatelessWidget {
  static final rainbowColors = <MaterialColor>[
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.pink
  ];

  static final circleRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      duration: Duration(seconds: 10),
      tween: rainbowTween(),
      child: CircleText(),
      builderWithChild: (context, child, color) {
        return Container(
          child: child,
          width: circleRadius * 2,
          height: circleRadius * 2,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(circleRadius))),
        );
      },
    );
  }

  TweenSequence rainbowTween() {
    final items = <TweenSequenceItem>[];
    for (int i = 0; i < rainbowColors.length - 1; i++) {
      items.add(TweenSequenceItem(
          tween: ColorTween(begin: rainbowColors[i], end: rainbowColors[i + 1]),
          weight: 1));
    }
    return TweenSequence(items);
  }
}

class CircleText extends StatelessWidget {
  static final thinkText =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 19);
  static final boldText = thinkText.copyWith(fontWeight: FontWeight.bold);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Welcome',
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 30)),
        //Text("Sign In", style: thinkText),
      ],
    );
  }
}
