import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:instaclone/components/roundedbutton.dart';
import 'package:instaclone/constants.dart';
import 'package:instaclone/screens/profile_screen.dart';
import 'package:instaclone/services/networking.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  String username;
  AnimationController controller;
  Animation animation;
  Map jsData;
  bool showSpinner = false;
  bool invalidUser = false;

  Future<void> getData() async {
    jsData = await NetworkHelper("https://www.instagram.com/$username/?__a=1")
        .getData();
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('images/logo.png'),
                    height: (animation.value) * 100,
                  ),
                  TypewriterAnimatedTextKit(
                    text: ['Instagram'],
                    textStyle: TextStyle(
                      fontFamily: 'Billabong',
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your username'),
              ),
              if (invalidUser)
                Text(
                  'Invalid username!',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w600),
                ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  await getData();
                  if (jsData != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(data: jsData)));
                  } else {
                    setState(() {
                      invalidUser = true;
                    });
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
