import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vwmdb/movie/data/datasources/latest_movie_remote_sources.dart';
import 'package:vwmdb/movie/data/repositories/latest_movie_repository.dart';
import 'package:vwmdb/movie/domain/usecases/latest_movie_usecase.dart';
import '../carousel.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
          child: MyWidget(),
        ),],),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: UpperSide(),
          ),
          Expanded(
            child: LowerSide(),
          ),
        ]
    );
  }
}

class UpperSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoonLoopingDemo();
  }
}

class LowerSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget> [
          Text('볼만한 것들'),
          Text('박스오피스'),
          Container(height: 300, child:BoxOfficeListView()),
        ]
    );
  }
}

class BoxOfficeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: <Widget>[
        Container(width: 150.0, color: Colors.blue,),
        Container(width: 150.0, color: Colors.green,),
        Container(width: 150.0, color: Colors.cyan,),
        Container(width: 150.0, color: Colors.black,),
      ],
    );
  }
}

class LatestMoviesViewModel {
  LatestMovieRemoteDataSource latestMovieRemoteDataSource = LatestMovieRemoteDataSourceImpl();
  //LatestMovieRepository latestMovieRepository = LatestMovieRepositoryImpl(latestMovieRemoteDataSource);
  //LatestMovieUsecase latestMovieUsecase = LatestMovieUsecase(latestMovieRepository);
}