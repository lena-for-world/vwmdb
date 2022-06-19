import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/core/network/poster.dart';
import '../../../data/models/movie/single_movie_model.dart';
import '../../viewmodels/movie/movie_viewmodel.dart';
import '../../viewmodels/rate/rate_viewmodel.dart';
import '../../viewmodels/rate/watchlist_viewmodel.dart';
import '../../widgets/rate/rating_bar_widget.dart';
import '../rate/review_page.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class SingleMoviePage extends ConsumerWidget {

  final int movieId;

  SingleMoviePage(this.movieId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<SingleMovieModel> singleMovieModel = ref.watch(singleMovieProvider(movieId));
    return singleMovieModel.when(
      data: (data) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('${data.title}'),
            ),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                    width: constraints.maxWidth,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleMoviePageDetail(data),
                    ),
                  );
                },

            ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
    error: (err, stack) => Text('${err}'),
    );
  }
}

class SingleMoviePageDetail extends ConsumerWidget {

  SingleMovieModel singleMovie;

  SingleMoviePageDetail(this.singleMovie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(starStateProvider);
    ref.watch(checkInWatchListStateProvider);
    double? movieRatedByMe = ref.watch(ratedStarsProvider(singleMovie.movieId));
    bool ifInWatchList = ref.read(ifInWatchListProvider(singleMovie.movieId));
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        width: constraints.maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Container(
              padding: EdgeInsets.only(left: 20, top: 30, bottom: 30,),
              child: Text('${singleMovie.title}'),
            ),
            Container(
              width: constraints.maxWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  Text('${singleMovie.year}'), Text('age'), Text('${singleMovie.runtime} minutes'),
                ],
            ),),
            SizedBox(height: 20,),
            Row(
              children: <Widget> [
                Container(
                  width: constraints.maxWidth/2,
                  height: 240,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: singleMovie.poster == defaultPoster
                        ? Image.asset(defaultPoster,
                      cacheWidth: 140,
                      cacheHeight: 210,
                    )
                        : Image.network('https://image.tmdb.org/t/p/w500/${singleMovie.poster}',
                      cacheWidth: 140,
                      cacheHeight: 210,
                    ),
                  ),

                  padding: EdgeInsets.only(left: 20, right: 30, bottom: 10, top: 40),
                ),
                Container(
                  width: constraints.maxWidth/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text('${singleMovie.genres}'),
                      SizedBox(height: 20),
                      // LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
                      //   return Container(
                      /*
                       layoutbuilder를 한번 더 사용하면 제대로 안 나오는데, 기존 layoutbuilder 안에 또 선언해서 사용하려고 했기 때문인듯?
                       걍 쓰면 잘 나옴ㅎ
                      */Text('${singleMovie.overview}'),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: ElevatedButton(
                child: Row(
                  children: <Widget> [
                    Icon(Icons.add, size: 16),
                    SizedBox(width: 10),
                    ifInWatchList ? Text('시청목록에서 삭제') : Text('시청목록에 추가'),
                  ],
                ),
                onPressed: () {
                  ref.read(postMovieToWatchListProvider(singleMovie));
                  ref.read(checkInWatchListStateProvider.state).state++;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Column(
                  children: [
                    Icon(Icons.favorite),
                    Text('${singleMovie.voteAverage} / ${singleMovie.voteCount}'),
                    Text('rating by others'),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  children: [
                    StarsButton(singleMovie),
                    movieRatedByMe == null ? Text('') : Text('${movieRatedByMe*2} / 10'),
                    Text('rating by me'),
                  ],
                ),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(singleMovie.movieId)));
                }, icon: Icon(Icons.reviews)),
              ],
            ),
          ],
        ),
      );}
    );
  }
}
