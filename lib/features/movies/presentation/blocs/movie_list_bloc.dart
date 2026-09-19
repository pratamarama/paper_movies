import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paper_movies/enums/app_error.dart';
import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/domain/usecases/filter_movie_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/get_category_list_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/get_movie_list_use_case.dart';
import 'package:paper_movies/features/movies/domain/usecases/search_movie_use_case.dart';

part 'movie_list_bloc.freezed.dart';
part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetMovieListUseCase _getMovieListUseCase;
  final FilterMovieUseCase _filterMovieUseCase;
  final SearchMovieUseCase _searchMovieUseCase;
  final GetCategoryListUseCase _getCategoryListUseCase;

  MovieListBloc({
    required GetMovieListUseCase getMovieListUseCase,
    required FilterMovieUseCase filterMovieUseCase,
    required SearchMovieUseCase searchMovieUseCase,
    required GetCategoryListUseCase getCategoryListUseCase,
  }) : _getCategoryListUseCase = getCategoryListUseCase,
       _searchMovieUseCase = searchMovieUseCase,
       _filterMovieUseCase = filterMovieUseCase,
       _getMovieListUseCase = getMovieListUseCase,
       super(const MovieListState()) {
    on<_Initial>(_onInitial);
    on<_FetchMovieList>(_onFetchMovieList);
    on<_Filter>(_onFilter);
    on<_Search>(_onSearch);
  }

  Future<void> _onInitial(_Initial event, Emitter<MovieListState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final List<Category> categoryList = await _getCategoryListUseCase.execute();

      emit(state.copyWith(categoryList: categoryList, isLoading: false));
    } catch (e) {
      final String errorMessage = e is AppError ? e.message : 'Something went wrong.';

      debugPrint(e.toString());
      emit(state.copyWith(isLoading: false, errorMessage: () => errorMessage));
    }

    add(const _FetchMovieList());
  }

  Future<void> _onFetchMovieList(_FetchMovieList event, Emitter<MovieListState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final List<Movie> movieList = await _getMovieListUseCase.execute(page: 1);

      emit(
        state.copyWith(
          initialMovieList: movieList,
          movieList: movieList,
          isLoading: false,
        ),
      );
    } catch (e) {
      final String errorMessage = e is AppError ? e.message : 'Something went wrong.';

      debugPrint(e.toString());
      emit(state.copyWith(isLoading: false, errorMessage: () => errorMessage));
    }
  }

  Future<void> _onFilter(_Filter event, Emitter<MovieListState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final (List<Movie>, List<Category>) filterMovie = _filterMovieUseCase.execute(
        movieList: state.initialMovieList,
        categoryIndex: event.categoryIndex,
        categoryList: state.categoryList,
      );

      emit(state.copyWith(movieList: filterMovie.$1, isLoading: false, categoryList: filterMovie.$2));
    } catch (e) {
      final String errorMessage = e is AppError ? e.message : 'Something went wrong.';

      debugPrint(e.toString());
      emit(state.copyWith(isLoading: false, errorMessage: () => errorMessage));
    }
  }

  Future<void> _onSearch(_Search event, Emitter<MovieListState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final int categoryIndex = state.categoryList.indexWhere((Category element) => element.activeStatus);

      final (List<Movie>, List<Category>) filterMovie = _filterMovieUseCase.execute(
        movieList: state.initialMovieList,
        categoryIndex: categoryIndex,
        categoryList: state.categoryList,
      );

      final List<Movie> movieList = _searchMovieUseCase.execute(
        movieList: filterMovie.$1,
        text: event.text,
      );

      emit(state.copyWith(movieList: movieList, isLoading: false));
    } catch (e) {
      final String errorMessage = e is AppError ? e.message : 'Something went wrong.';

      debugPrint(e.toString());
      emit(state.copyWith(isLoading: false, errorMessage: () => errorMessage));
    }
  }
}
