import 'package:get_it/get_it.dart';
import 'package:paper_movies/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:paper_movies/features/movies/data/datasources/remote/api_service.dart';
import 'package:paper_movies/features/movies/data/datasources/remote/dio_client.dart';
import 'package:paper_movies/features/movies/data/mappers/movie_mapper.dart';
import 'package:paper_movies/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:paper_movies/features/movies/domain/repositories/movie_repository.dart';

/// Created by Pratama Ramadhan on 19/09/26.

final GetIt injector = GetIt.instance;

Future<void> init() async {
  injector.registerLazySingleton<DioClient>(() => DioClient());
  injector.registerLazySingleton<ApiService>(() => ApiServiceImpl(dioClient: injector<DioClient>().dio));

  injector.registerLazySingleton<MovieRemoteDatasource>(() => MovieRemoteDatasourceImpl(apiService: injector()));

  injector.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(movieRemoteDatasource: injector(), movieMapper: const MovieMapper()),
  );
}
