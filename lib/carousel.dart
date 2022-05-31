import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoonLoopingDemo extends StatelessWidget {
  static List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  List<Widget> imageSliders = ImageSliderWidgets(imgList).makeImageSliderWidgets();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 4.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: 2,
              viewportFraction: 1,
              autoPlay: true,
            ),
            items: imageSliders,

    );
  }
}

class ImageSliderWidgets {
  final List<String> imgList;
  ImageSliderWidgets(this.imgList);
  List<Widget> makeImageSliderWidgets() {
    return imgList.map((item) => Container(
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
                      child: Image.network('https://image.tmdb.org/t/p/w500/bm7UlW3ctMJAvD6NNXrCDdRyyKn.jpg'),
                      onPressed: (){print('latest trailer button');},
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 30,
                    child: Row(
                      children: [
                        Image.network(item, fit: BoxFit.fill, width: 180.0, height: 240),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('title'),
                            Text('runnintime'),
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
                          onPressed: (){ print('title ${imgList.indexOf(item)}');},
                          child: Text('title ${imgList.indexOf(item)}'),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: (){print('latest');},
            ),
        ),
      ),
    ))
        .toList();
  }
}