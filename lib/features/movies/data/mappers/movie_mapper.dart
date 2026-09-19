import 'package:paper_movies/features/movies/data/models/movie_model.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class MovieMapper {
  const MovieMapper();

  Movie fromModel(MovieModel model) {
    return Movie(
      title: model.title ?? '',
      releaseDate: model.releaseDate ?? DateTime.fromMillisecondsSinceEpoch(0),
      voteAverage: model.voteAverage ?? 0,
      posterPath: model.posterPath,
    );
  }
}
