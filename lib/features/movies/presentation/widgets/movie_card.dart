import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper_movies/constants/app_padding.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/presentation/extensions/build_context.dart';

/// Created by Pratama Ramadhan on 19/09/26.

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.colorScheme.primaryContainer,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingSm),
        child: Row(
          children: <Widget>[
            _PosterTile(posterPath: movie.posterUrl ?? ''),
            const SizedBox(width: kPaddingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(movie.releaseDate),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rate, size: 14, color: Colors.orange),
                      const SizedBox(width: kPaddingXs),
                      Text(
                        movie.displayVoteAverage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterTile extends StatelessWidget {
  const _PosterTile({required this.posterPath});

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.2;
    final double height = width * 1006 / 749;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: posterPath,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
