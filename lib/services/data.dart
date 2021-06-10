import 'package:flutter/material.dart';

class ProfileModel {
  final String username;
  final int followers, followings, posts;
  final String dpUrl, dpUrlHd, bio, name, link, email;
  final bool isPrivate;

  ProfileModel({
    @required this.username,
    this.isPrivate,
    this.dpUrl,
    this.dpUrlHd,
    this.followings,
    this.followers,
    this.posts,
    this.email,
    this.link,
    this.name,
    this.bio,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      dpUrl: json['graphql']['user']['profile_pic_url'],
      dpUrlHd: json['graphql']['user']['profile_pic_url_hd'],
      followers: json['graphql']['user']['edge_followed_by']['count'],
      followings: json['graphql']['user']['edge_follow']['count'],
      posts: json['graphql']['user']['edge_owner_to_timeline_media']['count'],
      username: json['graphql']['user']['username'],
      bio: json['graphql']['user']['biography'],
      name: json['graphql']['user']['full_name'],
      link: json['graphql']['user']['external_url'],
      email: json['graphql']['user']['business_email'],
      isPrivate: json['graphql']['user']['is_private'],
    );
  }
}
