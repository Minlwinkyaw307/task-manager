import 'package:flutter/material.dart';

class BottomSheetOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color textColor;
  final Function onPress;

  BottomSheetOptionTile({
    @required this.icon,
    @required this.iconColor,
    @required this.title,
    @required this.textColor,
    @required this.onPress,
});

  @override
  Widget build(BuildContext context) {
    // list of tile that will show on long press task card
    return GestureDetector(
      child: ListTile(
        leading: Icon(
          icon,
          size: 27,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        onTap: () => onPress(),
      ),
    );
  }
}
