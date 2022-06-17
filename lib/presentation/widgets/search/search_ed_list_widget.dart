import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/search/search_viewmodel.dart';

final queryProvider = Provider<String>((ref) => '');

class SearchedList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> searchedList = ref.read(searchedHistoryProvider);
    return ListView.separated(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: searchedList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: SearchedListItem(searchedList[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class SearchedListItem extends ConsumerWidget {

  String item;

  SearchedListItem(this.item);

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
            'ed1 : ${ref.read(searchTrackProvider.state).state = item}');
        print('ed2 : ${ref.read(searchState.state).state}');
        ref.read(searchState.state).state = true;
        print('ed3 : ${ref.read(searchState.state).state}');
      },
    );
  }
}