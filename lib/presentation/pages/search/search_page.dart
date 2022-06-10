import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/pages/search/search_bar_result_page.dart';

import '../../../search_results_page.dart';
import '../../viewmodels/search/search_viewmodel.dart';
import '../../widgets/search/contents_list_view.dart';
import '../../../data/models/search/searched_movie_model.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

final searchState = StateProvider<bool>((ref) => false);

class SearchPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.read(searchState.state).state);
    ref.watch(searchState);
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
              ref.read(searchState.state).state ? Text('검색하기') : Text('   최근 검색'),
              SizedBox(height: 20),
              Divider(thickness: 2,),
              SizedBox(height: 20,),
              ref.read(searchState.state).state ? SearchingResultList() : SearchedItemsListView(),
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
    inputText = ref.read(searchTrackProvider.state).state; // watch로 만들면 변경될 때마다 재빌드하기 때문에 read 사용
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ref.read(searchState.state).state == false ? Text('') : Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => ref.read(searchState.state).state = false,
          ),
        ),
        Expanded(
          flex: 8,
          child: TextField(
            controller: TextEditingController(text: ref.read(searchTrackProvider.state).state),
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
              ref.read(searchState.state).state = true;
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
                ref.read(searchState.state).state = false;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultPage(inputText)));
              }),
        ),
      ],);
  }
}