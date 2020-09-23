import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  FollowButton({@required this.title, @required this.onPressed});
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 30.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.all(5.0),
      color: Colors.blueAccent,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
