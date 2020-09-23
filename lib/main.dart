import 'package:flutter/material.dart';
import 'package:instaclone/screens/welcome_screen.dart';
import 'package:instaclone/screens/profile_screen.dart';

void main() => runApp(InstaClone());

class InstaClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: WelcomeScreen(),
    );
  }
}
