import 'package:intl/intl.dart';
import 'package:paper_movies/constants/api_constant.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class Movie {
  final String title;
  final DateTime releaseDate;
  final double voteAverage;
  final String? posterPath;

  const Movie({required this.title, required this.releaseDate, required this.voteAverage, required this.posterPath});
}

extension MovieX on Movie {
  String? get posterUrl {
    if (posterPath == null) return null;
    return '${ApiConstant.imageBaseUrl}/t/p/w500/${posterPath!}';
  }

  String get displayVoteAverage {
    return voteAverage.toStringAsFixed(1);
  }

  String get displayReleaseDate {
    return DateFormat('yyyy-MM-dd').format(releaseDate);
  }
}
