import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/pages/movie/movie_detail_page.dart';
import 'package:vwmdb/presentation/viewmodels/rate/rate_viewmodel.dart';

import 'data/models/rate/rate_model.dart';

// 리뷰, 별점 리스트 출력에 사용할 위젯

class EvaluatedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                width: constraints.maxWidth,
                padding: EdgeInsets.all(30),
                child: EvaluatedListView(),
              );
            },
          ),
    );
  }
}

class EvaluatedListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<RateModel> ratedList = ref.watch(rateProvider).checkAllMoviesIfInRatedList();
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(ratedList.length, (index) {
        return Container(
          child: EvaluatedListItemView(ratedList[index]),
        );},
      ),
    );
  }
}

class EvaluatedListItemView extends StatelessWidget {

  RateModel rateModel;

  EvaluatedListItemView(this.rateModel);

  @override
  Widget build(BuildContext context) {
    return InkWell( // 누르면 영화 상세 페이지로 이동
        splashColor: Colors.white,
        highlightColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.only(right: 10, bottom: 10),
              child: ClipRect(
                child: Image.network('https://image.tmdb.org/t/p/w500${rateModel.poster}'),
              ),
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
      ), onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder:
            (context) => SingleMoviePage(rateModel.movieId)
          )
        );}
      );
  }
}