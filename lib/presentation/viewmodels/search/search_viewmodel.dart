import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/datasources/search/searched_movie_local_source.dart';
import '../../../data/datasources/search/searched_movie_remote_data_source.dart';
import '../../../data/models/search/searched_movie_model.dart';
import '../../../data/repositories/search/searched_movie_local_repository.dart';
import '../../../data/repositories/search/searched_movie_repository.dart';
import '../../../domain/usecases/search/searched_movie_local_usecase.dart';
import '../../../domain/usecases/search/searched_movie_usecase.dart';

final searchTrackProvider = StateProvider<String>((ref) => '');

final searchState = StateProvider<bool>((ref) => false);

final searchedResultProvider = FutureProvider.family<List<SearchedMovieModel>, String> ((ref, input) async {
  ref.watch(searchTrackProvider);
  SearchedRemoteDatasource searchedRemoteDatasource = SearchedRemoteDatasourceImpl();
  SearchedMovieRepository searchedMovieRepository = SearchedMovieRepositoryImpl(searchedRemoteDatasource);
  SearchedMovieUsecase searchedMovieUsecase = SearchedMovieUsecase(searchedMovieRepository);
  return await searchedMovieUsecase.getSearchedMovies(input);
});

final searchedLocalProvider = Provider<SearchedMovieLocalUsecase>((ref) {
  SearchedMovieLocalSource searchedMovieLocalSource = SearchedMovieLocalSourceImpl(Hive.box('myMovies'));
  SearchedMovieLocalRepository searchedMovieLocalRepository = SearchedMovieLocalRepositoryImpl(searchedMovieLocalSource);
  return SearchedMovieLocalUsecase(searchedMovieLocalRepository);
});

final searchedHistoryProvider = Provider<List<String>>((ref) {
  SearchedMovieLocalUsecase searchedMovieLocalUsecase = ref.watch(searchedLocalProvider);
  return searchedMovieLocalUsecase.getSearchedMoviesInLocal();
});

final saveSearchedMovieProvider = Provider.family<void, String>((ref, input) {
  SearchedMovieLocalUsecase searchedMovieLocalUsecase = ref.watch(searchedLocalProvider);
  searchedMovieLocalUsecase.saveSearchedMovieInLocal(input);
});