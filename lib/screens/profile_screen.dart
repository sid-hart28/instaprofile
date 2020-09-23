import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaclone/constants.dart';
import 'package:instaclone/screens/photo_screen.dart';
import 'package:instaclone/components/borderbutton.dart';
import 'package:instaclone/components/followbutton.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  var data;
  ProfileScreen({Key key, @required this.data}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(data);
}

class _ProfileScreenState extends State<ProfileScreen> {
  var data;
  _ProfileScreenState(this.data);

  @override
  void initState() {
    super.initState();
    getData();
  }

  String dpUrl, username, name, bio, link, dpUrlHd, email;
  int followers, followings, posts;
  bool isPrivate;

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

  void getData() async {
    var userData = data['graphql']['user'];
    dpUrl = userData['profile_pic_url'];
    dpUrlHd = userData['profile_pic_url_hd'];
    followers = userData['edge_followed_by']['count'];
    followings = userData['edge_follow']['count'];
    posts = userData['edge_owner_to_timeline_media']['count'];
    username = userData['username'];
    bio = userData['biography'];
    name = userData['full_name'];
    link = userData['external_url'];
    email = userData['business_email'];
    isPrivate = userData['is_private'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          username,
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
                                        PhotoScreen(dpUrlHd: dpUrlHd)));
                          },
                          child: CircleAvatar(
                            radius: 47.0,
                            backgroundImage: NetworkImage(dpUrl),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              posts.toString(),
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
                              followers.toString(),
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
                              followings.toString(),
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
                      name,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: (link != null)
                        ? Text(
                            bio + "\n" + link,
                            style: TextStyle(fontSize: 15.0),
                          )
                        : Text(
                            bio,
                            style: TextStyle(fontSize: 15.0),
                          ),
                  ),
                  SizedBox(height: 20.0),
                  Row(children: [
                    Expanded(
                      child: FollowButton(
                        onPressed: () {
                          _launchUniversalLinks(
                              "https://www.instagram.com/$username/");
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
                                      PhotoScreen(dpUrlHd: dpUrlHd)));
                        },
                        title: "View DP",
                      ),
                    ),
                    SizedBox(width: 8.0),
                    if (email != null)
                      Expanded(
                        child: BorderButton(
                            onPressed: () {
                              final Uri _emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: email,
                              );
                              launch(_emailLaunchUri.toString());
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
