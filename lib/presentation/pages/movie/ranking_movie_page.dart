import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vwmdb/presentation/widgets/movie/latest_movie_carousel_widget.dart';
import 'package:vwmdb/presentation/widgets/movie/boxoffice_movie_list_widget.dart';

class RankingMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                    height: constraints.maxHeight,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight/2,
                          child: LatestMoviesCarouselWidget(),
                        ),
                        Container(
                          height: constraints.maxHeight/2,
                          child: BoxOfficeList(),
                        ),
                      ],
                ),);}
            ),
        )
      );
  }
}