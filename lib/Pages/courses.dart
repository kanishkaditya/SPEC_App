import 'package:flutter/material.dart';
import 'file:///D:/flutterApps/app/lib/Components/CustomWidget/search.dart';

class courses extends StatefulWidget {
  @override
  _coursesState createState() => _coursesState();
}

class _coursesState extends State<courses> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/studyBackground.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        "Meditation",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Study Material",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: size.width * .6, // it just take 60% of total width
                        child: Text(
                          "Previous year papers, books, notes of first year and ECE department and books of ECE department is provided here",
                        ),
                      ),
                      SizedBox(
                        width: size.width * .5, // it just take the 50% width
                        child: SearchBar(),
                      ),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: <Widget>[
                          notesBox(
                            seassionNum: 1,
                            isDone: true,
                            press: () {},
                          ),
                          notesBox(
                            seassionNum: 2,
                            press: () {},
                          ),
                          notesBox(
                            seassionNum: 3,
                            press: () {},
                          ),
                          notesBox(
                            seassionNum: 4,
                            press: () {},
                          ),
                          notesBox(
                            seassionNum: 5,
                            press: () {},
                          ),
                          notesBox(
                            seassionNum: 6,
                            press: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Videos",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

class notesBox extends StatelessWidget {
  final int seassionNum;
  final bool isDone;
  final Function press;
  const notesBox({
    Key key,
    this.seassionNum,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: Colors.black26,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.deepPurpleAccent),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color:  Colors.deepPurpleAccent,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Year $seassionNum",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
