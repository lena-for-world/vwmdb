import 'package:vwmdb/movie/data/models/latest_movie_model.dart';

import '../../domain/entities/movie_entity.dart';
import '../datasources/movie_remote_data_source.dart';

abstract class MovieRepository {
  Future<Movie> getSingleMovieDetail(int);
}