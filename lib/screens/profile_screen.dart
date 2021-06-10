import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/constants.dart';
import 'package:instaclone/screens/photo_screen.dart';
import 'package:instaclone/components/borderbutton.dart';
import 'package:instaclone/components/followbutton.dart';
import 'package:instaclone/services/data.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  ProfileModel pData;
  ProfileScreen({Key key, @required this.pData}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(pData);
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel pData;
  _ProfileScreenState(this.pData);

  Future<void> _launchUniversalLinks(String url) async {
    if (await canLaunch(url)) {
      final bool launchAppSucceed = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!launchAppSucceed) {
        await launch(url, forceSafariVC: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          pData.username,
          textAlign: TextAlign.start,
        ),
        elevation: 5.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                print("icon clicked");
              })
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PhotoScreen(dpUrlHd: pData.dpUrlHd)));
                          },
                          child: CircleAvatar(
                            radius: 47.0,
                            backgroundImage: NetworkImage(pData.dpUrl),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              pData.posts.toString(),
                              style: kNumbersStyle,
                            ),
                            Text('Posts'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              pData.followers.toString(),
                              style: kNumbersStyle,
                            ),
                            Text('Followers'),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              pData.followings.toString(),
                              style: kNumbersStyle,
                            ),
                            Text('Followings'),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      pData.name,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: (pData.link != null)
                        ? Text(
                            pData.bio + "\n" + pData.link,
                            style: TextStyle(fontSize: 15.0),
                          )
                        : Text(
                            pData.bio,
                            style: TextStyle(fontSize: 15.0),
                          ),
                  ),
                  SizedBox(height: 20.0),
                  Row(children: [
                    Expanded(
                      child: FollowButton(
                        onPressed: () {
                          _launchUniversalLinks(
                              "https://www.instagram.com/${pData.username}/");
                        },
                        title: 'Follow',
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: BorderButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhotoScreen(dpUrlHd: pData.dpUrlHd)));
                        },
                        title: "View DP",
                      ),
                    ),
                    SizedBox(width: 8.0),
                    if (pData.email != null)
                      Expanded(
                        child: BorderButton(
                            onPressed: () {
                              // final Uri _emailLaunchUri = Uri(
                              //   scheme: 'mailto',
                              //   path: email,
                              // );
                              // launch(_emailLaunchUri.toString());
                            },
                            title: 'Email'),
                      ),
                  ]),
                  SizedBox(height: 25.0),
                  Container(
                    padding: EdgeInsets.all(50.0),
                    child: Image.asset('images/locklogo.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
