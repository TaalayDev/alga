import 'package:alga/data/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Widget? errorWidget;

  AppNetworkImage({
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      errorWidget: (context, url, _) => errorWidget ?? Icon(Icons.error),
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppThemeData.accent),
                value: progress.totalSize != null
                    ? progress.downloaded / progress.totalSize!
                    : null),
          ),
        );
      },
    );
  }
}
