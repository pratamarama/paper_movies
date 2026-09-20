import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Created by Pratama Ramadhan on 20/09/26.

class PosterTile extends StatelessWidget {
  final String posterPath;
  final double width;
  final double height;
  const PosterTile({required this.posterPath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: posterPath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (BuildContext context, String url, Object error) => const Icon(
          Icons.broken_image,
          size: 50,
          color: Colors.grey,
        ),
      ),
    );
  }
}
