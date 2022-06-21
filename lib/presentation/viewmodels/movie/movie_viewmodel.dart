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
import 'fix_movie_viewmodel.dart';

final latestMoviesProvider = FutureProvider.autoDispose<List<LatestMovieModel>> ((ref) async {
  final latestMoviesList = await ref.watch(latestMovieUsecaseProvider).getLatestMovies();
  return latestMoviesList;
});

final singleMovieProvider = FutureProvider.autoDispose.family<SingleMovieModel, int> ((ref, movieId) async {
  final singleMovie = await ref.watch(singleMovieUsecaseProvider).getSingleMovieDetail(movieId);
  return singleMovie;
});

final boxofficeMoviesProvider = FutureProvider.autoDispose<List<BoxofficeMovieModel>> ((ref) async {
  ref.watch(checkInWatchListStateProvider);
  final boxofficeMoviesList = await ref.watch(boxofficeMovieUsecaseProvider).getBoxofficeMovies();
  return boxofficeMoviesList;
});

final trailerIdProvider = FutureProvider.autoDispose.family<String, int> ((ref, id) async {
  return await ref.watch(latestMovieUsecaseProvider).getTrailer(id);
});

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

// final movieViewModelProvider = ChangeNotifierProvider<MovieViewModel>((ref) {
//   return MovieViewModel(
//       latestMovieUsecase: ref.watch(latestMovieUsecaseProvider),
//       boxofficeMovieUsecase: ref.watch(boxofficeMovieUsecaseProvider),
//       singleMovieUsecase: ref.watch(singleMovieUsecaseProvider)
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
// // boxofficeMoviesProvider를 watch하는 위젯이 있음. 그래서 checkInWatchListStateProvider는 autoDispose가 걸려있어도
// // 계속 listen되고 있는상태이므로 dispose 안 됨. 만약 boxofficeMoviesProvider를 read하고 있었다면 dispose됐을 것
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