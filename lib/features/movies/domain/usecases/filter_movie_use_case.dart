import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class FilterMovieUseCase {
  List<Movie> execute({required List<Movie> movieList, required int rateValue}) {
    final List<Movie> filteredList = movieList.where((Movie element) => element.voteAverage >= rateValue).toList();
    return filteredList;
  }
}
