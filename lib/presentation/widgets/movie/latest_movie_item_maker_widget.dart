import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/widgets/movie/trailer_widget.dart';
import '../../../data/models/movie/latest_movie_model.dart';
import '../../pages/movie/movie_detail_page.dart';

class ImageSlider {
  AsyncValue<List<LatestMovieModel>> latestMovieModelList;

  ImageSlider(this.latestMovieModelList);

  List<String> imgList = [];

  List<Widget> giveWidgets() {
    List<Widget> list = [];
    return latestMovieModelList.when(
      data: (data) {
        data.forEach((element) {
          list.add(MakeLatestMovieItem(element));
        });
        return list;
      },
      loading: () => [Center(child: CircularProgressIndicator())],
      error: (err, stack) => [Text('error')],
    );
  }
}

// 일반 클래스에서 호출했는데 어떻게 context를 받을 수 있던거지...?
class MakeLatestMovieItem extends StatelessWidget{
  LatestMovieModel movieModel;

  MakeLatestMovieItem(this.movieModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return  Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  child: InkWell( // 누르면 영화 상세 페이지로 이동
                    splashColor: Colors.white,
                    highlightColor: Colors.black,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 50,
                          bottom: 40,
                          child: Container(
                            height: constraints.maxHeight/2,
                            child: Row(
                              children: [
                                ClipRect(
                                    child: Image.network('https://image.tmdb.org/t/p/w500${movieModel.poster}')
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          top: 100,
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
                            child: TextButton(
                              onPressed: () {
                                // movieId 트레일러 다이얼로그 띄우기
                              },
                              child: Text(
                                '${movieModel.title}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight,
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(Icons.play_circle_fill_sharp, size: 50),
                              color: Colors.yellowAccent,
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TrailerFrame(movieModel.movieId);
                                    }
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print('// SingleMoviePage item.movieId로 이동');
                      // navigation 적용
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (context) => SingleMoviePage(movieModel.movieId)
                      )
                      );
                    },
                  ),
                ),
              );}));
  }
}