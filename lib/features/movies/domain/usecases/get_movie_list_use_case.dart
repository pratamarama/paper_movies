import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/domain/repositories/movie_repository.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class GetMovieListUseCase {
  final MovieRepository _movieRepository;
  const GetMovieListUseCase({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  Future<List<Movie>> execute({required int page}) async {
    final List<Movie> movieList = await _movieRepository.getMovieList(page: page);
    return movieList;
  }
}
