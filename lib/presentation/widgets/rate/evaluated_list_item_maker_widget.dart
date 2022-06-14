import 'package:flutter/material.dart';
import 'package:vwmdb/presentation/pages/movie/movie_detail_page.dart';

import '../../../data/models/rate/rate_model.dart';

class EvaluatedListItem extends StatelessWidget {

  RateModel rateModel;
  //int length;

  EvaluatedListItem(this.rateModel);//, this.length);

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
                      child: Image.network(
                          'https://image.tmdb.org/t/p/w500${rateModel.poster}',
                          cacheHeight: 222,
                          cacheWidth: 148,
                      ),
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