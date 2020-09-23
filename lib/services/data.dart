import 'networking.dart';
import 'package:instaclone/screens/welcome_screen.dart';

class InstaModel {
  Future<dynamic> getProfileData(String username) async {
    var url = "https://www.instagram.com/$username/?__a=1";
    NetworkHelper networkHelper = NetworkHelper(url);
    var instaData = await networkHelper.getData();
    return instaData;
  }
}
