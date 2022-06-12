import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/datasources/search/searched_movie_local_source.dart';
import '../../../data/repositories/search/searched_movie_local_repository.dart';
import '../../../domain/usecases/search/searched_movie_local_usecase.dart';
import '../../pages/search/search_page.dart';
import '../../viewmodels/search/search_viewmodel.dart';

final searchedProvider = Provider<SearchedMovieLocalUsecase>((ref) {
  SearchedMovieLocalSource searchedMovieLocalSource = SearchedMovieLocalSourceImpl(Hive.box('myMovies'));
  SearchedMovieLocalRepository searchedMovieLocalRepository = SearchedMovieLocalRepositoryImpl(searchedMovieLocalSource);
  SearchedMovieLocalUsecase searchedMovieLocalUsecase = SearchedMovieLocalUsecase(searchedMovieLocalRepository);
  return searchedMovieLocalUsecase;
});

final queryProvider = Provider<String>((ref) => '');

class SearchedItemsListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> searchedList = ref.watch(searchedProvider).getSearchedMoviesInLocal();
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
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

class SearchedItemView extends ConsumerWidget {

  String item;

  SearchedItemView(this.item);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell( // 누르면 영화 상세 페이지로 이동
        splashColor: Colors.white,
        highlightColor: Colors.black,
          child:Container(
            height: 80,
            padding: EdgeInsets.all(5),
            child: Container(
              width: 50,
              child: Text('${item}'),
            ),
          ),
      onTap: () {
        ref.read(searchTrackProvider.state).state = item;
        print(
            ref.read(searchTrackProvider.state).state = item);
        print(ref.read(searchState.state).state);
        ref.read(searchState.state).state = true;
        print(ref.read(searchState.state).state);
      },
    );
  }
}