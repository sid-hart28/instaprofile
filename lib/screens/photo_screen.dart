import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
  String dpUrlHd;
  PhotoScreen({Key key, @required this.dpUrlHd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(dpUrlHd),
      ),
    );
  }
}
