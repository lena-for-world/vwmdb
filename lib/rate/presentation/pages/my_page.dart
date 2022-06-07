import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/movie/data/models/single_movie_model.dart';
import 'package:vwmdb/rate/presentation/viewmodels/rate_viewmodel.dart';
import '../../../evaluated_list_view.dart';
import '../../../movie/presentation/viewmodels/movie_viewmodel.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyPageView(),
        ),
      ),
    );
  }
}

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Row(
            children: <Widget> [
              Expanded (
                child: TextButton(
                  child: Container(
                    width: 100, height: 100,
                    child: Align(alignment: Alignment.center, child: Text('내 평가'),),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:
                        (context) => EvaluatedView()));
                  },
                ),
              ),
              Expanded (
                child: TextButton(
                  child: Container(
                    width: 100, height: 100,
                    child: Align(alignment: Alignment.center, child: Text('내 리뷰'),),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(20),
            child:
            Text('나중에 볼 영화들'),
          ),
          SizedBox(height: 20),
          Container(height: 300, child: WatchListView(),),
        ],
      ),
    );
  }
}

class WatchListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(checkInWatchListStateProvider);
    List<WatchListItemView> resultList = [];
    List<int> inWatchLists = ref.watch(rateProvider).checkAllMoviesIfInWatchList();
    inWatchLists.forEach((element) {
        var res = ref.read(singleMovieProvider(element));
        res.when(
          data: (data) {
            resultList.add(WatchListItemView(data));
          },
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => [err],
        );
      });
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: resultList.length,
      itemBuilder: (BuildContext context, int index) {
        return resultList[index];
      },
    );
  }
}

class WatchListItemView extends ConsumerWidget {

  late int movieId;
  SingleMovieModel singleMovie;
  WatchListItemView(this.singleMovie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    movieId = singleMovie.movieId;
//    bool checkedIfInWatchList = ref.watch(rateProvider).getIfMovieInWatchList(movieId);
    return Stack(
        children: <Widget> [
          TextButton(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget> [
                  Container(
                    width: 150,
                    height: 180,
                    child: Image.network('https://image.tmdb.org/t/p/w500/${singleMovie.poster}'),
                  ),
                  SizedBox(height: 10),
                  Text('${singleMovie.title}'),
                ],
              ),
            ),
            onPressed: () {print('sazz');},
        ),
          IconButton (
            icon: Icon(Icons.check),
            iconSize: 20,
            onPressed: () {
              ref.read(rateProvider).postCheckOrUncheckMovieInWatchList(movieId);
              ref.read(checkInWatchListStateProvider.state).state++;
            },
          )
        ],
    );
  }
}