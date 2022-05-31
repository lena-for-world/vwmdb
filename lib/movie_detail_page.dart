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
        appBar: AppBar(title: Text('Title')),
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
      width: 1000,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(left: 20, top: 30, bottom: 30,),
            child: Text('title'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [
              Text('year'), Text('age'), Text('runningtime'),
            ],
          ),
          Row(
            children: <Widget> [
              Container(
                width: 200,
                height: 240,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                ),

                padding: EdgeInsets.only(left: 20, right: 30, bottom: 10, top: 40),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text('genre'),
                  SizedBox(height: 20),
                  Text('content'),
                ],
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
                  Text('시청목록에 추가'),
                ],
              ),
              onPressed: () {print('시청목록에 추가');},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Column(
                children: [
                  Icon(Icons.favorite),
                  Text('7.4/10'),
                  Text('rating by others'),
                ],
              ),
              SizedBox(width: 30),
              Column(
                children: [
                  Icon(Icons.favorite),
                  Text('7.4/10'),
                  Text('rating by me'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
