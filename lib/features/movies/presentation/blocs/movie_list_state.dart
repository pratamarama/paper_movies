part of 'movie_list_bloc.dart';

@freezed
abstract class MovieListState with _$MovieListState {
  const factory MovieListState({
    @Default(false) bool isLoading,
    String Function()? errorMessage,
    @Default(<Movie>[]) List<Movie> initialMovieList,
    @Default(<Movie>[]) List<Movie> movieList,
    @Default(<Category>[]) List<Category> categoryList,
  }) = _MovieListState;
}
