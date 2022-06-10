import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/pages/movie/boxoffice_movie_view.dart';
import 'package:vwmdb/presentation/pages/movie/latest_movie_view.dart';
import 'package:vwmdb/presentation/viewmodels/movie/movie_viewmodel.dart';
import 'package:vwmdb/presentation/viewmodels/rate/rate_viewmodel.dart';

import 'data/models/movie/boxoffice_movie_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                print(constraints.maxHeight);
                return Container(
                    height: constraints.maxHeight,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight/2,
                          child: LatestMovieView(),
                        ),
                        Container(
                          height: constraints.maxHeight/2,
                          child: LowerSide(),
                        ),
                      ],
                ),);}
            ),
        )
      );
  }
}

class LowerSide extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight,
                  color: Colors.red,
                  child:
                      BoxOfficeListView(),
                  );
              }
          );
  }
}

class BoxOfficeListView extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // TODO : ref.watch가 탭을 이동했다가 다시 돌아왔을때도 새로호출하려면 autodispose써야함.. 근데 의도대로 동작안하는경우도있어서 알아보기
   AsyncValue<List<BoxofficeMovieModel>> boxofficeMovies = ref.watch(boxofficeMoviesProvider);

    return boxofficeMovies.when(
      data: (data) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                bool isInWatchList = ref.read(rateProvider).getIfMovieInWatchList(data[index].movieId);
                return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                      child: BoxOfficeMovieListItem(data[index], index, isInWatchList),
                      height: constraints.maxHeight,
                  );
                });
              }
            ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('boxofficelistview error: ${err}'),
    );
  }
}