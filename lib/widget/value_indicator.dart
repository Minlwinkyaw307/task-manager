import 'package:flutter/material.dart';

class ValueIndicator extends StatelessWidget {
  final String title;
  final Color color;
  final int count;

  ValueIndicator({@required this.title, @required this.color, @required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          color: this.color,
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontFamily: 'QuickSand'
            ),
            children: [
              TextSpan(
                text: '${this.title} ',

              ),
              TextSpan(
                text: '(${this.count.toString()})',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
