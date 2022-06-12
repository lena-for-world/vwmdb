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
        body:
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
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
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: ratedList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3/2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => Container(
            child: EvaluatedListItemView(ratedList[index]),//, ratedList.length~/3),
          ),
        );
  }
}

class EvaluatedListItemView extends StatelessWidget {

  RateModel rateModel;
  //int length;

  EvaluatedListItemView(this.rateModel);//, this.length);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return InkWell( // 누르면 영화 상세 페이지로 이동
            splashColor: Colors.white,
            highlightColor: Colors.white,
            child: Container(
                width: constraints.maxWidth/3,
                height: constraints.maxHeight,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Container(
                      height: constraints.maxHeight/3*2,
                      child: ClipRect(
                        child: Image.network('https://image.tmdb.org/t/p/w500${rateModel.poster}'),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Center(child: Text('${rateModel.title}',),),
                          Text('${rateModel.stars!*2}'),
                        ],
                     )),
                  ],
                )
            ), onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder:
              (context) => SingleMoviePage(rateModel.movieId)
          )
          );}
        );
    });
  }
}