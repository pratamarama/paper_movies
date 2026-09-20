import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/domain/repositories/movie_repository.dart';
import 'package:paper_movies/features/movies/domain/usecases/filter_movie_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/get_category_list_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/get_movie_list_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/search_movie_use_case.dart';

/// Created by Pratama Ramadhan on 20/09/26.

class _MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('GetMovieListUseCase', () {
    late MovieRepository repository;
    late GetMovieListUseCase useCase;

    setUp(() {
      repository = _MockMovieRepository();
      useCase = GetMovieListUseCase(movieRepository: repository);
    });

    test('returns movie list from repository', () async {
      final List<Movie> movies = <Movie>[
        Movie(title: 'Inception', releaseDate: DateTime(2024, 1, 1), voteAverage: 8.7),
        Movie(title: 'Interstellar', releaseDate: DateTime(2024, 2, 2), voteAverage: 8.9),
      ];

      when(() => repository.getMovieList(page: 1)).thenAnswer((_) async => movies);

      final List<Movie> result = await useCase.execute(page: 1);

      expect(result, movies);
      verify(() => repository.getMovieList(page: 1)).called(1);
    });
  });

  group('GetCategoryListUseCase', () {
    late MovieRepository repository;
    late GetCategoryListUseCase useCase;

    setUp(() {
      repository = _MockMovieRepository();
      useCase = GetCategoryListUseCase(movieRepository: repository);
    });

    test('returns category list from repository', () async {
      final List<Category> categories = <Category>[
        const Category(name: 'All', rateValue: 0, activeStatus: true),
        const Category(name: 'Good', rateValue: 7, activeStatus: false),
      ];

      when(() => repository.getCategoryList).thenReturn(categories);

      final List<Category> result = await useCase.execute();

      expect(result, categories);
      verify(() => repository.getCategoryList).called(1);
    });
  });

  group('SearchMovieUseCase', () {
    test('filters movies by title ignoring case', () {
      final List<Movie> movies = <Movie>[
        Movie(title: 'Inception', releaseDate: DateTime(2024, 1, 1), voteAverage: 8.7),
        Movie(title: 'The Batman', releaseDate: DateTime(2024, 3, 1), voteAverage: 8.4),
      ];

      final List<Movie> result = SearchMovieUseCase().execute(movieList: movies, text: 'bat');

      expect(result, <Movie>[movies[1]]);
    });

    test('returns empty list when search text does not match', () {
      final List<Movie> movies = <Movie>[
        Movie(title: 'Inception', releaseDate: DateTime(2024, 1, 1), voteAverage: 8.7),
      ];

      final List<Movie> result = SearchMovieUseCase().execute(movieList: movies, text: 'xyz');

      expect(result, isEmpty);
    });
  });

  group('FilterMovieUseCase', () {
    test('returns all movies when category is All', () {
      final List<Movie> movies = <Movie>[
        Movie(title: 'Inception', releaseDate: DateTime(2024, 1, 1), voteAverage: 8.7),
        Movie(title: 'Interstellar', releaseDate: DateTime(2024, 2, 2), voteAverage: 8.9),
      ];
      final List<Category> categories = <Category>[
        const Category(name: 'All', rateValue: 0, activeStatus: true),
        const Category(name: 'Bad', rateValue: 4, activeStatus: false),
      ];

      final (List<Movie>, List<Category>) result = FilterMovieUseCase().execute(
        movieList: movies,
        categoryIndex: 0,
        categoryList: categories,
      );

      expect(result.$1, movies);
      expect(result.$2[0].activeStatus, isTrue);
      expect(result.$2[1].activeStatus, isFalse);
    });

    test('filters movies by vote range for selected category', () {
      final List<Movie> movies = <Movie>[
        Movie(title: 'Low Movie', releaseDate: DateTime(2024, 1, 1), voteAverage: 2.0),
        Movie(title: 'Okay Movie', releaseDate: DateTime(2024, 2, 2), voteAverage: 5.5),
        Movie(title: 'Great Movie', releaseDate: DateTime(2024, 3, 3), voteAverage: 8.2),
      ];
      final List<Category> categories = <Category>[
        const Category(name: 'All', rateValue: 0, activeStatus: false),
        const Category(name: 'Bad', rateValue: 4, activeStatus: false),
        const Category(name: 'Good', rateValue: 6, activeStatus: false),
      ];

      final (List<Movie>, List<Category>) result = FilterMovieUseCase().execute(
        movieList: movies,
        categoryIndex: 1,
        categoryList: categories,
      );

      expect(result.$1, <Movie>[movies[1]]);
      expect(result.$2[1].activeStatus, isTrue);
    });
  });
}
