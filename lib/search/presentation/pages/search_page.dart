import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/search_viewmodel.dart';
import '../widgets/contents_list_view.dart';
import '../../data/models/searched_movie_model.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchInputArea(),
              SizedBox(height: 30),
              Text('   최근 검색'),
              SizedBox(height: 20),
              Divider(thickness: 2,),
              SizedBox(height: 20,),
              SearchedListArea(),
            ],
          )
        ),
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
            onTap: () {
              var tapState = ref.read(tappedProvider.state).state;
              ref.read(tappedProvider.state).state = !tapState;
              print('tapState ${tapState}');
            },
          ),
        ),
        SizedBox(width: 35),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              child: Text('검색'),
              onPressed: () {
                // 검색 키워드 저장
                ref.read(searchedProvider).saveSearchedMovieInLocal(inputText);
              }),
        ),
      ],);
  }
}

class SearchedListArea extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool ifTapped = ref.watch(tappedProvider);
    return ifTapped ? SearchingResultList() : SearchedItemsListView();
  }
}

class SearchingResultList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String input = ref.watch(searchTrackProvider.state).state;
    AsyncValue<List<SearchedMovieModel>> resultList = ref.watch(searchedResultProvider(input));
    return input == '' ? Text('검색어를 입력해주세요') : resultList.when(
      data: (data) {
        print(data);
        return SingleChildScrollView(
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
    return Container(
        height: 80,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Image.network('https://image.tmdb.org/t/p/w500${searchedMovieModel.poster}'),
            ),

            Column(
              children: [
                Text('${searchedMovieModel.title}'),
                SizedBox(height: 5),
              ],
            )
          ],
        )
    );
  }
}