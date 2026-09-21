import 'package:flutter/material.dart';
import 'package:paper_movies/constants/app_padding.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/presentation/extensions/build_context.dart';
import 'package:paper_movies/features/movies/presentation/widgets/poster_tile.dart';

/// Created by Pratama Ramadhan on 20/09/26.

class MovieTabletCard extends StatelessWidget {
  final Movie movie;
  const MovieTabletCard({super.key, required this.movie});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Builder(
              builder: (BuildContext context) {
                final double width = (MediaQuery.sizeOf(context).width - kPaddingSm) / 3;
                final double height = width * backdropRatio;
                return PosterTile(posterPath: movie.backdropUrl ?? '', width: width, height: height);
              },
            ),
            const SizedBox(height: kPaddingXs),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: kPaddingXs),
            Text(
              movie.displayReleaseDate,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: kPaddingXs),
            Row(
              children: <Widget>[
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
    );
  }
}
