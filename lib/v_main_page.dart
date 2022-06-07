import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/movie/presentation/pages/boxoffice_movie_view.dart';
import 'package:vwmdb/rate/presentation/viewmodels/rate_viewmodel.dart';
import 'movie/presentation/pages/latest_movie_view.dart';
import 'movie/data/models/boxoffice_movie_model.dart';
import 'movie/presentation/viewmodels/movie_viewmodel.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: LatestMovieView(),
                ),
                Expanded(
                  child: LowerSide(),
                ),
              ]
          ),
        ),],),
      ),
    );
  }
}

class LowerSide extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget> [
          Text('박스 오피스'),
          Container(height: 300, child:BoxOfficeListView()),
        ]
    );
  }
}

class BoxOfficeListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AsyncValue<List<BoxofficeMovieModel>> boxofficeMovies = ref.watch(boxofficeMoviesProvider);

    return boxofficeMovies.when(
      data: (data) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              bool isInWatchList = ref.read(rateProvider).getIfMovieInWatchList(data[index].movieId);
              return BoxOfficeMovieListItem(data[index], index, isInWatchList);
            },
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('boxofficelistview error: ${err}'),
    );
  }
}