part of 'movie_list_bloc.dart';

@freezed
abstract class MovieListEvent with _$MovieListEvent {
  const factory MovieListEvent.initial() = _Initial;
  const factory MovieListEvent.filter({required int categoryIndex}) = _Filter;
  const factory MovieListEvent.search({required String text}) = _Search;
}
