import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/viewmodels/movie/single_movie_viewmodel.dart';
import '../../../data/datasources/movie/movie_remote_data_source.dart';
import '../../../data/models/movie/boxoffice_movie_model.dart';
import '../../../data/models/movie/latest_movie_model.dart';
import '../../../data/models/movie/single_movie_model.dart';
import '../../../data/repositories/movie/movie_repository.dart';
import '../../../domain/usecases/movie/boxoffice_movie_usecase.dart';
import '../../../domain/usecases/movie/latest_movie_usecase.dart';
import '../../../domain/usecases/movie/single_movie_usecase.dart';
import '../rate/rate_viewmodel.dart';
import 'fix_movie_viewmodel.dart';

// final latestMoviesProvider = FutureProvider.autoDispose<List<LatestMovieModel>> ((ref) async {
//   final latestMoviesList = await ref.watch(latestMovieUsecaseProvider).getLatestMovies();
//   return latestMoviesList;
// });
//
final singleMovieProvider = FutureProvider.autoDispose.family<SingleMovieModel, int> ((ref, movieId) async {
  ref.watch(checkInWatchListStateProvider);
  final singleMovie = await ref.watch(singleMovieUsecaseProvider).getSingleMovieDetail(movieId);
  return singleMovie;
});
//
// final boxofficeMoviesProvider = FutureProvider.autoDispose<List<BoxofficeMovieModel>> ((ref) async {
//   ref.watch(checkInWatchListStateProvider);
//   final boxofficeMoviesList = await ref.watch(boxofficeMovieUsecaseProvider).getBoxofficeMovies();
//   return boxofficeMoviesList;
// });
//
// final trailerIdProvider = FutureProvider.autoDispose.family<String, int> ((ref, id) async {
//   return await ref.watch(latestMovieUsecaseProvider).getTrailer(id);
// });

final movieRemoteDataSourceProvider = Provider.autoDispose<MovieRemoteDataSource>((ref) {
  return MovieRemoteDataSourceImpl();
});

final movieRepositoryProvider = Provider.autoDispose<MovieRepository>((ref) {
  return MovieRepositoryImpl(ref.watch(movieRemoteDataSourceProvider));
});

final latestMovieUsecaseProvider = Provider.autoDispose<LatestMovieUsecase>((ref) {
  return LatestMovieUsecase(ref.watch(movieRepositoryProvider));
});

final boxofficeMovieUsecaseProvider = Provider.autoDispose<BoxofficeMovieUsecase>((ref) {
  return BoxofficeMovieUsecase(ref.watch(movieRepositoryProvider));
});

final singleMovieUsecaseProvider = Provider.autoDispose<SingleMovieUsecase>((ref) {
  return SingleMovieUsecase(ref.watch(movieRepositoryProvider));
});

final movieViewModelProvider = ChangeNotifierProvider.autoDispose<MovieViewModel>((ref) {
  return MovieViewModel(
      latestMovieUsecase: ref.watch(latestMovieUsecaseProvider),
      boxofficeMovieUsecase: ref.watch(boxofficeMovieUsecaseProvider)
  );
});

// final singleMovieViewModelProvider = ChangeNotifierProvider<SingleMovieViewModel>((ref) {
//   return SingleMovieViewModel(
//     singleMovieUsecase: ref.watch(singleMovieUsecaseProvider),
//   );
// });

// final refreshMainProvider = FutureProvider<void>((ref) async {
// MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
//     MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
// await LatestMovieUsecase(movieRepository).getLatestMovies();
// });

// final latestMoviesProvider = FutureProvider<List<LatestMovieModel>> ((ref) async {
//   MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
//   MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
//   final latestMoviesList = await LatestMovieUsecase(movieRepository).getLatestMovies();
//   return latestMoviesList;
// });
//
// final singleMovieProvider = FutureProvider.family<SingleMovieModel, int> ((ref, movieId) async {
//   MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
//   MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
//   final singleMovie = await SingleMovieUsecase(movieRepository).getSingleMovieDetail(movieId);
//   return singleMovie;
// });
//
// // boxofficeMoviesProvider??? watch?????? ????????? ??????. ????????? checkInWatchListStateProvider??? autoDispose??? ???????????????
// // ?????? listen?????? ????????????????????? dispose ??? ???. ?????? boxofficeMoviesProvider??? read?????? ???????????? dispose?????? ???
// final boxofficeMoviesProvider = FutureProvider.autoDispose<List<BoxofficeMovieModel>> ((ref) async {
//   ref.watch(checkInWatchListStateProvider);
//   MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
//   MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
//   final boxofficeMoviesList = await BoxofficeMovieUsecase(movieRepository).getBoxofficeMovies();
//   return boxofficeMoviesList;
// });
//
// final trailerIdProvider = FutureProvider.family<String, int> ((ref, id) async {
//   MovieRemoteDataSource movieRemoteDataSource = MovieRemoteDataSourceImpl();
//   MovieRepository movieRepository = MovieRepositoryImpl(movieRemoteDataSource);
//   return await LatestMovieUsecase(movieRepository).getTrailer(id);
// });