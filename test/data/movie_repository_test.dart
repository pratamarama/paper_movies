import 'package:flutter_test/flutter_test.dart';
import 'package:paper_movies/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:paper_movies/features/movies/data/mappers/movie_mapper.dart';
import 'package:paper_movies/features/movies/data/models/list_response_model.dart';
import 'package:paper_movies/features/movies/data/models/movie_model.dart';
import 'package:paper_movies/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

void main() {
  group('MovieRepositoryImpl', () {
    late MovieRemoteDatasource remoteDatasource;
    late MovieRepositoryImpl repository;

    setUp(() {
      remoteDatasource = _FakeMovieRemoteDatasource();
      repository = MovieRepositoryImpl(
        movieRemoteDatasource: remoteDatasource,
        movieMapper: const MovieMapper(),
      );
    });

    test('returns mapped movie entities from the remote datasource', () async {
      final List<Movie> result = await repository.getMovieList(page: 1);

      expect(result, isA<List<Movie>>());
      expect(result.length, 2);
      expect(result[0].title, 'Inception');
      expect(result[1].releaseDate, DateTime(2024, 1, 2));
    });

    test('returns default category list', () {
      final List<Category> result = repository.getCategoryList;

      expect(result, isA<List<Category>>());
      expect(result.first.name, 'All');
      expect(result.length, 5);
    });
  });
}

class _FakeMovieRemoteDatasource implements MovieRemoteDatasource {
  @override
  Future<ListResponseModel<MovieModel>?> getMovieList({
    required int page,
    Function(int, int)? onReceiveProgress,
  }) async {
    return ListResponseModel<MovieModel>(
      results: <MovieModel>[
        MovieModel(title: 'Inception', releaseDate: DateTime(2023, 1)),
        MovieModel(title: 'Interstellar', releaseDate: DateTime(2024, 1, 2)),
      ],
    );
  }
}
