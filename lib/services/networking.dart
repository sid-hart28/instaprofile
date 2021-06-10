import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data.dart';

Future<ProfileModel> instaData(String username) async {
  final response =
      await http.get(Uri.parse("https://www.instagram.com/$username/?__a=1"));

  if (response.statusCode == 200) {
    return ProfileModel.fromJson(jsonDecode(response.body));
  } else {
    return (null);
  }
}
