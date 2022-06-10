import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasources/search/searched_movie_remote_data_source.dart';
import '../../../data/models/search/searched_movie_model.dart';
import '../../../data/repositories/search/searched_movie_repository.dart';
import '../../../domain/usecases/search/searched_movie_usecase.dart';

final tappedProvider = StateProvider<bool>((ref) => false);

final searchTrackProvider = StateProvider<String>((ref) => '');

final searchedResultProvider = FutureProvider.family<List<SearchedMovieModel>, String> ((ref, input) async {
  ref.watch(searchTrackProvider);
  SearchedRemoteDatasource searchedRemoteDatasource = SearchedRemoteDatasourceImpl();
  SearchedMovieRepository searchedMovieRepository = SearchedMovieRepositoryImpl(searchedRemoteDatasource);
  SearchedMovieUsecase searchedMovieUsecase = SearchedMovieUsecase(searchedMovieRepository);
  return await searchedMovieUsecase.getSearchedMovies(input);
});