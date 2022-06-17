import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../pages/search/search_results_page.dart';
import '../../viewmodels/search/search_viewmodel.dart';

class SearchInputArea extends ConsumerWidget {

  String inputText = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    inputText = ref.read(searchTrackProvider.state).state; // watch로 만들면 변경될 때마다 재빌드하기 때문에 read 사용
    return Container(
        height: 60,
        child: Row(
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
                    ref.read(saveSearchedMovieProvider(inputText));
                    ref.read(searchState.state).state = false;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultsPage(inputText)));
                  }),
            ),
          ],));
  }
}