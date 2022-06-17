import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vwmdb/presentation/pages/rate/my_page.dart';
import 'package:vwmdb/presentation/pages/search/search_page.dart';
import 'package:vwmdb/presentation/pages/movie/ranking_movie_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myMovies');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return MaterialApp(
      title: _title,
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomeWidget()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        color: Colors.white,
        child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset('assets/images/movie.png', cacheWidth: 200, cacheHeight: 200),
        ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    RankingMoviesPage(),
    SearchPage(),
    MyPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie, color: Colors.greenAccent),
            label: 'movie home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            label: "movie",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.pinkAccent),
            label: "movie",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
