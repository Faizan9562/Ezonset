import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  String url;

  ImageView({this.url});
  
  @override
  Widget build(BuildContext context) {
  return Container(
    child: PhotoView(
      heroAttributes: PhotoViewHeroAttributes(tag: url),
      imageProvider: NetworkImage(url),
    )
  );
}
}