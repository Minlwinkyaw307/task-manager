import 'package:flutter/material.dart';

class ValueIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 15,
          height: 15,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: 'Done ',
              ),
              TextSpan(
                text: '(13)',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
