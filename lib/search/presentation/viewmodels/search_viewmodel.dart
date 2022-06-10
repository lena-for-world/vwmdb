import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/search/data/datasources/searched_movie_remote_data_source.dart';
import 'package:vwmdb/search/data/repositories/searched_movie_repository.dart';
import 'package:vwmdb/search/domain/usecases/searched_movie_usecase.dart';

import '../../data/models/searched_movie_model.dart';

final tappedProvider = StateProvider<bool>((ref) => false);

final searchTrackProvider = StateProvider<String>((ref) => '');

final searchedResultProvider = FutureProvider.family<List<SearchedMovieModel>, String> ((ref, input) async {
  ref.watch(searchTrackProvider);
  SearchedRemoteDatasource searchedRemoteDatasource = SearchedRemoteDatasourceImpl();
  SearchedMovieRepository searchedMovieRepository = SearchedMovieRepositoryImpl(searchedRemoteDatasource);
  SearchedMovieUsecase searchedMovieUsecase = SearchedMovieUsecase(searchedMovieRepository);
  return await searchedMovieUsecase.getSearchedMovies(input);
});