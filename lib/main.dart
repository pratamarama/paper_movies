import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_movies/constants/route_paths.dart';
import 'package:paper_movies/features/movies/di/injector.dart' as di;
import 'package:paper_movies/features/movies/domain/usecases/filter_movie_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/get_category_list_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/get_movie_list_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/search_movie_use_case.dart';
import 'package:paper_movies/features/movies/presentation/blocs/movie_list_bloc.dart';
import 'package:paper_movies/features/movies/presentation/pages/movie_list_page.dart';

void main() {
  di.init();
  runApp(const PaperMoviesApp());
}

class PaperMoviesApp extends StatefulWidget {
  const PaperMoviesApp({super.key});

  @override
  State<PaperMoviesApp> createState() => _PaperMoviesAppState();
}

class _PaperMoviesAppState extends State<PaperMoviesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paper Movies',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,

          primary: Color(0xFF187CBE),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFD2E9F9),
          onPrimaryContainer: Color(0xFF0B3452),

          secondary: Color(0xFF25AE88),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFD1F2E9),
          onSecondaryContainer: Color(0xFF0B4637),

          tertiary: Color(0xFF135F8E),
          onTertiary: Color(0xFFFFFFFF),

          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF2C3E50),

          error: Color(0xFFD94B4B),
          onError: Color(0xFFFFFFFF),

          outline: Color(0xFFE2E8F0),
          shadow: Color(0x0A000000),
        ),
      ),
      initialRoute: RoutePaths.movieList,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.movieList:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => BlocProvider<MovieListBloc>(
            create: (BuildContext context) => MovieListBloc(
              getCategoryListUseCase: GetCategoryListUseCase(movieRepository: di.injector()),
              getMovieListUseCase: GetMovieListUseCase(movieRepository: di.injector()),
              filterMovieUseCase: const FilterMovieUseCase(),
              searchMovieUseCase: SearchMovieUseCase(),
            ),
            child: const MovieListPage(),
          ),
        );

      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
