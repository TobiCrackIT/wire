import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Currency extends StatelessWidget {
  const Currency({
    Key? key,
    this.size = 36,
    required this.path,
  }) : super(key: key);

  final double size;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: CachedNetworkImage(
          imageUrl: path,
          placeholder: (_, __) => Container(
            color: Colors.grey[300],
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}