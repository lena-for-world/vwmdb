import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/movie/data/datasources/latest_movie_remote_sources.dart';
import 'package:vwmdb/movie/data/models/latest_movie_model.dart';
import 'package:vwmdb/movie/data/repositories/latest_movie_repository.dart';

import 'movie/domain/usecases/latest_movie_usecase.dart';

final latestMoviesProvider = FutureProvider<List<LatestMovieModel>> ((ref) async {
  LatestMovieRemoteDataSource latestMovieRemoteDataSource = LatestMovieRemoteDataSourceImpl();
  LatestMovieRepository latestMovieRepository = LatestMovieRepositoryImpl(latestMovieRemoteDataSource);
  final latestMoviesList = await LatestMovieUsecase(latestMovieRepository).getLatestMovies();
  return latestMoviesList;
});

class LatestMovieView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AsyncValue<List<LatestMovieModel>> latestMovieModelList = ref.watch(latestMoviesProvider);

    return CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 4.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: 2,
              viewportFraction: 1,
              autoPlay: true,
            ),
            items: ImageSliderWidgets(latestMovieModelList).makeImageSliderWidgets(),

    );
  }
}

class ImageSliderWidgets {
  AsyncValue<List<LatestMovieModel>> latestMovieModelList;
  ImageSliderWidgets(this.latestMovieModelList);

  List<String> imgList=[];

  List<Widget> makeImageSliderWidgets() {
    return latestMovieModelList.when(
      data: (data) {
        return makeLatestMovieWidgets(data);
      },
      loading: () => [CircularProgressIndicator()],
      error: (err, stack) => [Text('error')],
    );
  }

  List<Widget> makeLatestMovieWidgets(List<LatestMovieModel> movieModels) {
    return movieModels.map((item) => Container(
      child: Container(
        width: 1200,
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          child: InkWell( // 누르면 영화 상세 페이지로 이동
            splashColor: Colors.white,
            highlightColor: Colors.black,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: TextButton( // 누르면 트레일러 다이얼로그 팝업
                    child: Image.network('https://image.tmdb.org/t/p/w500/${item.poster}'),
                    onPressed: (){print('latest trailer button');},
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 30,
                  child: Row(
                    children: [
                      Image.network('https://image.tmdb.org/t/p/w500/${item.poster}', fit: BoxFit.fill, width: 180.0, height: 240),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${item.title}'),
                          Text('${item.year}'),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  top: 140,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: /*Text(
                        'No. ${imgList.indexOf(item)} image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),*/
                    TextButton(
                      onPressed: () {
                        // movieId 트레일러 다이얼로그 띄우기
                      },
                      child: Text('${item.title}'),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              print('// SingleMoviePage item.movieId로 이동');
              },
          ),
        ),
      ),
    ))
        .toList();
  }
}