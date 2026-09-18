import 'package:freezed_annotation/freezed_annotation.dart';

/// Created by Pratama Ramadhan on 18/09/26.

part 'list_response_model.freezed.dart';
part 'list_response_model.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class ListResponseModel<T> with _$ListResponseModel<T> {
  const factory ListResponseModel({
    @Default(1) int page,
    @Default(1) @JsonKey(name: 'total_pages') int totalPages,
    @JsonKey(name: 'results') List<T>? results,
  }) = _ListResponseModel<T>;

  factory ListResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ListResponseModelFromJson(json, fromJsonT);
}
