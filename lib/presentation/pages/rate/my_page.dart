import 'package:flutter/material.dart';
import 'evaluation_page.dart';
import '../../widgets/rate/watch_list_widget.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
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
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
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
                          (context) => EvaluationPage()));
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
            Container(height: 300, child: WatchList(),),
          ],
        ),
        ),
    );
  }
}