import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.035),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.search,
              color: const Color.fromRGBO(0, 0, 0, 0.5),
              size: 30,
            ),
            padding: const EdgeInsets.only(
              right: 15,
            ),
          ),
          Container(
            child: Text(
              "Search task",
              style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.35),
                  fontSize: 17,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
