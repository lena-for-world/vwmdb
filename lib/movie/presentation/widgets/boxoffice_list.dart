import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            height: 250,
            child: BoxOfficeListView(),
          ),
        ),
      ),
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
        Container(width: 160, child: Placeholder(),),
        Stack(
          children: <Widget> [
            Container(
              width: 150.0,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 170,
                    child:FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      ),
                    ),
                  ),
                  Container(
                      width: 120,
                      height: 70,
                      child: Column (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text('1'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [Text('star 1'), Text('star 2')],
                            ),
                            Text('title'),
                          ]
                      )
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {print('gg');},
            ),
          ],),],
    );
  }
}

class SingleMovieListItemView extends StatelessWidget {

  /*
    url 주소
    rank index
    rating by others
    rating by me
    title
  */

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.white,
        highlightColor: Colors.blue,
        child: Stack(
          children: <Widget> [
            Container(
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 170,
                    child:FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                      ),
                    ),
                  ),
                  Container(
                      width: 120,
                      height: 70,
                      child: Column (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text('rank index'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [Text('star 1'), Text('star 2')],
                            ),
                            Text('title'),
                          ]
                      )
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {print('gg');},
            ),
          ],),
        onTap: () {print('inkwell');}
    );
  }
}