import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  BorderButton({@required this.title, @required this.onPressed});
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: OutlineButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text(title),
      ),
    );
  }
}
