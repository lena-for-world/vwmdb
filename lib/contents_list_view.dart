import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 검색결과, 리뷰, 별점 리스트 출력에 사용할 위젯

class SearchedItemsListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: SearchedItemView(),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class SearchedItemView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            ),

            Column(
              children: [
                Text('title'),
                SizedBox(height: 5),
                Text('year'),
              ],
            )
          ],
        )
    );
  }
}