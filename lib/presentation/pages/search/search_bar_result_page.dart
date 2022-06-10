import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/search_results_page.dart';

import '../../viewmodels/search/search_viewmodel.dart';
import '../../widgets/search/contents_list_view.dart';
import '../../../data/models/search/searched_movie_model.dart';
import '../movie/movie_detail_page.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class SearchBarResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchInputArea(),
                SizedBox(height: 30),
                Divider(thickness: 2,),
                SizedBox(height: 20,),
                SearchingResultList(),
              ],
            )
        ),
    );
  }
}

class SearchInputArea extends ConsumerWidget {

  String inputText = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          flex: 8,
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
            onChanged: (text) {
              inputText = text;
              ref.read(searchTrackProvider.state).state = inputText;
            },
          ),
        ),
        SizedBox(width: 35),
        Expanded(
          flex: 2,
          child: ElevatedButton(
              child: Text('검색'),
              onPressed: () {
                // 검색 키워드 저장
                ref.read(searchedProvider).saveSearchedMovieInLocal(inputText);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultPage(inputText)));
              }),
        ),
      ],);
  }
}

class SearchingResultList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String input = ref.watch(searchTrackProvider.state).state;
    AsyncValue<List<SearchedMovieModel>> resultList = ref.watch(searchedResultProvider(input));
    return input == '' ? Text('검색어를 입력해주세요') : resultList.when(
      data: (data) {
        return data.length == 0
            ? Text('검색 결과가 없어요')
            : SingleChildScrollView(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: SearchingResultItem(data[index]),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
            );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('${err}'),
    );
  }
}

class SearchingResultItem extends StatelessWidget {

  SearchedMovieModel searchedMovieModel;

  SearchingResultItem(this.searchedMovieModel);

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
                child: searchedMovieModel.poster == 'null' ? SizedBox() : Image.network('https://image.tmdb.org/t/p/w500${searchedMovieModel.poster}'),
              ),

              Column(
                children: [
                  Text('${searchedMovieModel.title}'),
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
  }
}