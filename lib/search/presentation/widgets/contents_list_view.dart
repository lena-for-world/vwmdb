import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/search/data/datasources/searched_movie_local_source.dart';
import 'package:vwmdb/search/data/repositories/searched_movie_local_repository.dart';
import 'package:vwmdb/search/domain/usecases/searched_movie_local_usecase.dart';

final searchedProvider = Provider<SearchedMovieLocalUsecase>((ref) {
  SearchedMovieLocalSource searchedMovieLocalSource = SearchedMovieLocalSourceImpl(Hive.box('myMovies'));
  SearchedMovieLocalRepository searchedMovieLocalRepository = SearchedMovieLocalRepositoryImpl(searchedMovieLocalSource);
  SearchedMovieLocalUsecase searchedMovieLocalUsecase = SearchedMovieLocalUsecase(searchedMovieLocalRepository);
  return searchedMovieLocalUsecase;
});

class SearchedItemsListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> searchedList = ref.watch(searchedProvider).getSearchedMoviesInLocal();
    print('SearchedItemsListView${searchedList.runtimeType}');
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: searchedList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: SearchedItemView(searchedList[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class SearchedItemView extends StatelessWidget {

  String item;

  SearchedItemView(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: EdgeInsets.all(5),
        child: Text('${item}'),
    );
  }
}