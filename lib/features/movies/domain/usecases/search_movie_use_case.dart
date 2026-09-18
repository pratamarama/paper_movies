import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class SearchMovieUseCase {
  List<Movie> execute({required List<Movie> movieList, required String text}) {
    final List<Movie> filteredList = movieList
        .where((Movie element) => element.title.toLowerCase().contains(text.toLowerCase()))
        .toList();
    return filteredList;
  }
}
