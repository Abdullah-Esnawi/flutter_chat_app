import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';



class AppImages {
  const AppImages._();

  static const splashIcon = AppImage('splash_icon');
  static const defaultProfilePicture = AppImage('default_profile_picture');
  static const landingScreenBackground = AppImage('landing_screen_background');
  static const chatScreenBackground = AppImage('chat_background');
}


class SvgImage extends StatelessWidget {
  final AppImage image;
  final double? width;
  final double? height;

  const SvgImage(
    this.image, {
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'lib/core/resources/assets/images/${image.name}.svg',
      width: width,
      height: height,
    );
  }
}

class AppNetworkImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxShape shape;
  final Color? color;

  const AppNetworkImage(
    this.image, {
    super.key,
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 2),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          color: color,
        ),
      ),
    );
  }
}

class AppAssetImage extends StatelessWidget {
  final AppImage image;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Color? color;

  const AppAssetImage(
    this.image, {
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: Image.asset(
        'lib/core/resources/assets/images/${image.name}.png',
        fit: fit,
        color: color,
      ),
    );
  }
}

class AppImage {
  final String name;

  const AppImage(this.name);
}

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
  });
  final String url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
      ),
    );
  }
}
