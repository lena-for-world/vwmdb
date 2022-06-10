import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/movie/latest_movie_model.dart';
import '../../widgets/movie/trailer_widget.dart';
import 'movie_detail_page.dart';
import '../../viewmodels/movie/movie_viewmodel.dart';

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
            items: ImageSliderWidgets(latestMovieModelList, context).makeImageSliderWidgets(),

    );
  }
}

class ImageSliderWidgets {
  AsyncValue<List<LatestMovieModel>> latestMovieModelList;
  BuildContext context;

  ImageSliderWidgets(this.latestMovieModelList, this.context);

  List<String> imgList=[];

  List<Widget> makeImageSliderWidgets() {
    return latestMovieModelList.when(
      data: (data) {
        return makeLatestMovieWidgets(data, context);
      },
      loading: () => [CircularProgressIndicator()],
      error: (err, stack) => [Text('error')],
    );
  }

  List<Widget> makeLatestMovieWidgets(List<LatestMovieModel> movieModels, BuildContext context) {
    return movieModels.map((item) => Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return  Container(
        width: constraints.maxHeight,
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          child: InkWell( // 누르면 영화 상세 페이지로 이동
            splashColor: Colors.white,
            highlightColor: Colors.black,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                          icon: Icon(Icons.play_circle_fill_sharp),
                          color: Colors.yellowAccent,
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return YoutubeApp(item.movieId);
                              }
                            );
                          },
                        ),
                ),
                Positioned(
                  left: 20,
                  bottom: 30,
                  child: Container(
                    width: constraints.maxWidth/2,
                      height: constraints.maxHeight/2,
                      child: Row(
                        children: [
                        FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          child: Image.network('https://image.tmdb.org/t/p/w500${item.poster}')
                        )),
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
              // navigation 적용
              Navigator.of(context).push(MaterialPageRoute(builder:
                (context) => SingleMoviePage(item.movieId)
                )
              );
              },
          ),
        ),
      );}),
    ))
        .toList();
  }
}