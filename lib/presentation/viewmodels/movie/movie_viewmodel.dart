import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasources/movie/movie_remote_data_source.dart';
import '../../../data/models/movie/boxoffice_movie_model.dart';
import '../../../data/models/movie/latest_movie_model.dart';
import '../../../data/models/movie/single_movie_model.dart';
import '../../../data/repositories/movie/movie_repository.dart';
import '../../../domain/usecases/movie/boxoffice_movie_usecase.dart';
import '../../../domain/usecases/movie/latest_movie_usecase.dart';
import '../../../domain/usecases/movie/single_movie_usecase.dart';
import '../rate/rate_viewmodel.dart';

final latestMoviesProvider = FutureProvider<List<LatestMovieModel>> ((ref) async {
  MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
  MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
  final latestMoviesList = await LatestMovieUsecase(movieRepository).getLatestMovies();
  return latestMoviesList;
});

final singleMovieProvider = FutureProvider.family<SingleMovieModel, int> ((ref, movieId) async {
  MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
  MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
  final singleMovie = await SingleMovieUsecase(movieRepository).getSingleMovieDetail(movieId);
  return singleMovie;
});

final boxofficeMoviesProvider = FutureProvider.autoDispose<List<BoxofficeMovieModel>> ((ref) async {
  ref.watch(checkInWatchListStateProvider);
  MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
  MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
  final boxofficeMoviesList = await BoxofficeMovieUsecase(movieRepository).getBoxofficeMovies();
  return boxofficeMoviesList;
});

final trailerIdProvider = FutureProvider.family<String, int> ((ref, id) async {
  MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
  MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
  return await LatestMovieUsecase(movieRepository).getTrailer(id);
});