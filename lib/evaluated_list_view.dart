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
    var size = MediaQuery.of(context).size;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: ratedList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (size.width/3) / ((size.height - 30) / 3),
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
                        height: constraints.maxHeight/3,
                      child: Column(
                        children: [
                          Expanded(child: RichText(text: TextSpan( text: '${rateModel.title}', style: TextStyle(color: Colors.black, fontSize: 13),), maxLines: 2, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr,),),
                          //DefaultTextStyle(style: TextStyle(color: Colors.black, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: false, child: Text('${rateModel.title}',)),
                          Text('${rateModel.stars!*2}', style: TextStyle(fontSize: 13),),
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