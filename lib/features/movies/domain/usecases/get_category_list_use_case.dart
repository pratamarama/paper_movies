import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/repositories/movie_repository.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class GetCategoryListUseCase {
  final MovieRepository _movieRepository;
  const GetCategoryListUseCase({required MovieRepository movieRepository}) : _movieRepository = movieRepository;

  Future<List<Category>> execute() async {
    return _movieRepository.getCategoryList;
  }
}
