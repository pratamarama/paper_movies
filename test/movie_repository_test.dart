import 'package:flutter_test/flutter_test.dart';
import 'package:paper_movies/features/movies/data/datasources/remote/movie_remote_datasource.dart';
import 'package:paper_movies/features/movies/data/mappers/movie_mapper.dart';
import 'package:paper_movies/features/movies/data/models/list_response_model.dart';
import 'package:paper_movies/features/movies/data/models/movie_model.dart';
import 'package:paper_movies/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';

/// Created by Pratama Ramadhan on 18/09/26.

void main() {
  group('MovieRepositoryImpl', () {
    test('returns mapped movie entities from the remote datasource', () async {
      final _FakeMovieRemoteDatasource datasource = _FakeMovieRemoteDatasource();
      final MovieRepositoryImpl repository = MovieRepositoryImpl(
        remoteDatasource: datasource,
        movieMapper: const MovieMapper(),
      );

      final List<Movie> result = await repository.getMovieList();

      expect(result, isA<List<Movie>>());
      expect(result.length, 2);
      expect(result[0].title, 'Inception');
      expect(result[1].releaseDate, DateTime(2024, 1, 2));
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
