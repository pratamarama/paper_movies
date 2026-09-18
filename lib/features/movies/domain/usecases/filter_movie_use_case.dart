import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class FilterMovieUseCase {
  const FilterMovieUseCase();

  (List<Movie>, List<Category>) execute({
    required List<Movie> movieList,
    required int categoryIndex,
    required List<Category> categoryList,
  }) {
    final Category selectedCategory = categoryList[categoryIndex];

    final List<Category> newCategoryList = categoryList
        .map((Category e) => e.copyWith(activeStatus: e.name == selectedCategory.name))
        .toList();

    if (categoryIndex == 0) {
      return (movieList, newCategoryList);
    }

    final int startRate = selectedCategory.rateValue;
    final int endRate = categoryList.elementAtOrNull(categoryIndex + 1)?.rateValue ?? 10;

    final List<Movie> filteredList = movieList.where((Movie element) {
      final double voteAverage = element.voteAverage;
      return voteAverage >= startRate && voteAverage < endRate;
    }).toList();

    return (filteredList, newCategoryList);
  }
}
