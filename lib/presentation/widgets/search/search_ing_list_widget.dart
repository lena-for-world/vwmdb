import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodels/search/search_viewmodel.dart';
import '../../../data/models/search/searched_movie_model.dart';
import '../../pages/movie/movie_detail_page.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class SearchingList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String input = ref.watch(searchTrackProvider.state).state;
    AsyncValue<List<SearchedMovieModel>> resultList = ref.watch(searchedResultProvider(input));
    return input == ''
        ? Text('검색어를 입력해주세요')
        : resultList.when(
      data: (data) {
        return data.length == 0
            ? Text('검색 결과가 없어요')
            :  ListView.separated(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: SearchingListItem(data[index]),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
            );},
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('${err}'),
    );
  }
}

class SearchingListItem extends StatelessWidget {

  SearchedMovieModel searchedMovieModel;

  SearchingListItem(this.searchedMovieModel);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext builderContext, BoxConstraints constraints) {
      return InkWell( // 누르면 영화 상세 페이지로 이동
          splashColor: Colors.white,
          highlightColor: Colors.black,
          child:Container(
              width: constraints.maxWidth,
              height: 80,
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: searchedMovieModel.poster == 'null'
                        ? Image.asset('assets/images/default.jpeg')
                        : Image.network('https://image.tmdb.org/t/p/w500${searchedMovieModel.poster}'),
                  ),

                  Column(
                    children: [
                      Container(
                        width: 200,
                        child: Text('${searchedMovieModel.title}'),
                      ),
                      SizedBox(height: 5),
                    ],
                  )
                ],
              )
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder:
                (context) => SingleMoviePage(searchedMovieModel.movieId)
            )
            );
          }
      );
    });
  }
}