import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

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
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
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
                    child: Align(alignment: Alignment.center, child: Text('내 리뷰'),),
                  ),
                  onPressed: () {},
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
          Text('나중에 볼 영화들'),
          SizedBox(height: 20),
          Container(height: 300, child: WatchListView(),),
        ],
      ),
    );
  }
}

class WatchListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: <Widget>[
        WatchListItemView(),
        WatchListItemView(),
        WatchListItemView(),
      ],
    );
  }
}

class WatchListItemView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget> [
            Container(
              width: 150,
              height: 180,
              child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            ),
            SizedBox(height: 10),
            Text('title'),
          ],
        ),
      ),
      onPressed: () {print('sazz');},
    );
  }
}