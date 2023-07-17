import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String imageUrl;

  PhotoViewPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查看大图'),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(imageUrl),
        ),
      ),
    );
  }
}
