import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/pages/movie/movie_detail_page.dart';
import 'package:vwmdb/presentation/viewmodels/search/search_viewmodel.dart';
import '../../../data/models/search/searched_movie_model.dart';

class SearchedResultsList extends ConsumerWidget {

  String input;

  SearchedResultsList(this.input);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<SearchedMovieModel>> searchedResults = ref.watch(searchedResultProvider(input));
    return searchedResults.when(
      data: (data) {
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: SearchedResultItem(data[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      },
      loading: () => Center(child: LinearProgressIndicator(),),
      error: (err, stack) => Text('${err}'),
    );

  }
}

class SearchedResultItem extends StatelessWidget {

  SearchedMovieModel searchedMovieModel;

  SearchedResultItem(this.searchedMovieModel);

  @override
  Widget build(BuildContext context) {
    return InkWell( // 누르면 영화 상세 페이지로 이동
        splashColor: Colors.white,
        highlightColor: Colors.black,
        child:Container(
            height: 80,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: searchedMovieModel.poster == 'null'
                      ? Image.asset('assets/images/default.jpeg',
                    cacheWidth: 93,
                    cacheHeight: 140,
                  )
                      : Image.network('https://image.tmdb.org/t/p/w500${searchedMovieModel.poster}',
                    cacheWidth: 93,
                    cacheHeight: 140,
                  ),
                ),
                Container(
                  width: 200,
                  child: Text('${searchedMovieModel.title}'),
                ),
              ],
            )
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder:
              (context) => SingleMoviePage(searchedMovieModel.movieId)
          ));
        }
    );
  }
}