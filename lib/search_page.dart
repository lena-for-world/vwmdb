import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'contents_list_view.dart';

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
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchInputArea(),
              SizedBox(height: 30),
              Text('   최근 검색'),
              SizedBox(height: 20),
              Divider(thickness: 2,),
              SizedBox(height: 20,),
              SearchedItemsListView(),
            ],
          )
        ),
      ),
    );
  }
}

class SearchInputArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
        SizedBox(width: 35),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              child: Text('검색'),
              onPressed: () {
                // 검색 동작
              }),
        ),
      ],);
  }
}