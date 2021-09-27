import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadableImage extends StatelessWidget {
  final String imageUrl;
  final String fallbackAsset;
  final BoxFit fit;

  const LoadableImage({
    required this.imageUrl,
    required this.fallbackAsset,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl, fit: fit, loadingBuilder: (
      BuildContext context,
      Widget child,
      ImageChunkEvent? loadingProgress,
    ) {
      if (loadingProgress == null) {
        return child;
      }
      return CircularProgressIndicator();
    }, errorBuilder: (
      BuildContext context,
      Object error,
      StackTrace? stackTrace,
    ) {
      return SvgPicture.asset(fallbackAsset);
    });
  }
}
