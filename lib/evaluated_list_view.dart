import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/rate/data/models/rate_model.dart';
import 'package:vwmdb/rate/presentation/viewmodels/rate_viewmodel.dart';

// 리뷰, 별점 리스트 출력에 사용할 위젯

class EvaluatedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black26,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            padding: EdgeInsets.all(30),
            child: EvaluatedListView(),
        ),
      ),
    );
  }
}

class EvaluatedListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<RateModel> ratedList = ref.watch(rateProvider).checkAllMoviesIfInRatedList();
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: ratedList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: EvaluatedListItemView(ratedList[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class EvaluatedListItemView extends StatelessWidget {

  RateModel rateModel;

  EvaluatedListItemView(this.rateModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Image.network('https://image.tmdb.org/t/p/w500${rateModel.poster}'),
            ),

            Column(
              children: [
                Text('${rateModel.title}'),
                SizedBox(height: 5),
                Text('${rateModel.stars!*2}'),
              ],
            )
          ],
        )
    );
  }
}