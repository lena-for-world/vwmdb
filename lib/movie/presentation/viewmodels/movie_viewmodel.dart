import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/rate/presentation/viewmodels/rate_viewmodel.dart';
import '../../data/datasources/boxoffice_movie_remote_data_source.dart';
import '../../data/datasources/latest_movie_remote_sources.dart';
import '../../data/datasources/single_movie_remote_data_source.dart';
import '../../data/models/boxoffice_movie_model.dart';
import '../../data/models/latest_movie_model.dart';
import '../../data/models/single_movie_model.dart';
import '../../data/repositories/boxoffice_movie_repository.dart';
import '../../data/repositories/latest_movie_repository.dart';
import '../../data/repositories/single_movie_repository.dart';
import '../../domain/usecases/boxoffice_movie_usecase.dart';
import '../../domain/usecases/latest_movie_usecase.dart';
import '../../domain/usecases/single_movie_usecase.dart';

final latestMoviesProvider = FutureProvider<List<LatestMovieModel>> ((ref) async {
  LatestMovieRemoteDataSource latestMovieRemoteDataSource = LatestMovieRemoteDataSourceImpl();
  LatestMovieRepository latestMovieRepository = LatestMovieRepositoryImpl(latestMovieRemoteDataSource);
  final latestMoviesList = await LatestMovieUsecase(latestMovieRepository).getLatestMovies();
  return latestMoviesList;
});

final singleMovieProvider = FutureProvider.family<SingleMovieModel, int> ((ref, movieId) async {
  SingleMovieRemoteDataSource singleMovieRemoteDataSource = SingleMovieRemoteDataSourceImpl();
  SingleMovieRepository singleMovieRepository = SingleMovieRepositoryImpl(singleMovieRemoteDataSource);
  final singleMovie = await SingleMovieUsecase(singleMovieRepository).getSingleMovieDetail(movieId);
  return singleMovie;
});

final boxofficeMoviesProvider = FutureProvider.autoDispose<List<BoxofficeMovieModel>> ((ref) async {
  ref.watch(checkInWatchListStateProvider);
  BoxofficeMovieRemoteDataSource boxofficeMovieRemoteDataSource = BoxofficeMovieRemoteDataSourceImpl();
  BoxofficeMovieRepository boxofficeMovieRepository = BoxofficeMovieRepositoryImpl(boxofficeMovieRemoteDataSource);
  final boxofficeMoviesList = await BoxofficeMovieUsecase(boxofficeMovieRepository).getBoxofficeMovies();
  return boxofficeMoviesList;
});

final trailerIdProvider = FutureProvider.family<String, int> ((ref, id) async {
  LatestMovieRemoteDataSource latestMovieRemoteDataSource = LatestMovieRemoteDataSourceImpl();
  LatestMovieRepository latestMovieRepository = LatestMovieRepositoryImpl(latestMovieRemoteDataSource);
  return await LatestMovieUsecase(latestMovieRepository).getTrailer(id);
});