import 'package:paper_movies/features/movies/data/datasources/remote/movie_remote_datasource.dart';
import 'package:paper_movies/features/movies/data/mappers/movie_mapper.dart';
import 'package:paper_movies/features/movies/data/models/list_response_model.dart';
import 'package:paper_movies/features/movies/data/models/movie_model.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/domain/repositories/movie_repository.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource _remoteDatasource;
  final MovieMapper _movieMapper;

  const MovieRepositoryImpl({
    required MovieRemoteDatasource remoteDatasource,
    required MovieMapper movieMapper,
  }) : _remoteDatasource = remoteDatasource,
       _movieMapper = movieMapper;

  @override
  Future<List<Movie>> getMovieList({required int page}) async {
    final ListResponseModel<MovieModel>? response = await _remoteDatasource.getMovieList(page: page);
    final List<MovieModel> models = response?.results ?? const <MovieModel>[];

    return models.map((MovieModel movieModel) => _movieMapper.fromModel(movieModel)).toList();
  }
}
