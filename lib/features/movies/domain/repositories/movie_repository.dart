import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

abstract class MovieRepository {
  Future<List<Movie>> getMovieList({required int page});
  List<Category> get getCategoryList;
}
