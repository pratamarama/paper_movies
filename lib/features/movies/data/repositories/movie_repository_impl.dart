import 'package:paper_movies/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:paper_movies/features/movies/data/mappers/movie_mapper.dart';
import 'package:paper_movies/features/movies/data/models/list_response_model.dart';
import 'package:paper_movies/features/movies/data/models/movie_model.dart';
import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/domain/repositories/movie_repository.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource _movieRemoteDatasource;
  final MovieMapper _movieMapper;

  const MovieRepositoryImpl({
    required MovieRemoteDatasource movieRemoteDatasource,
    required MovieMapper movieMapper,
  }) : _movieRemoteDatasource = movieRemoteDatasource,
       _movieMapper = movieMapper;

  @override
  Future<List<Movie>> getMovieList({required int page}) async {
    final ListResponseModel<MovieModel>? response = await _movieRemoteDatasource.getMovieList(page: page);
    final List<MovieModel> models = response?.results ?? const <MovieModel>[];

    return models.map((MovieModel movieModel) => _movieMapper.fromModel(movieModel)).toList();
  }

  @override
  List<Category> get getCategoryList {
    return <Category>[
      const Category(name: 'All', rateValue: 2, activeStatus: true),
      const Category(name: 'Bad', rateValue: 4, activeStatus: false),
      const Category(name: 'Good', rateValue: 6, activeStatus: false),
      const Category(name: 'Great', rateValue: 8, activeStatus: false),
      const Category(name: 'Recommend', rateValue: 9, activeStatus: false),
    ];
  }
}
