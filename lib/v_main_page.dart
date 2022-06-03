import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/boxoffice_movie_view.dart';
import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';
import 'package:vwmdb/rate/data/repositories/rate_repository.dart';
import 'package:vwmdb/rate/domain/usecases/rate_usecase.dart';
import '../latest_movie_view.dart';
import 'movie/data/datasources/boxoffice_movie_remote_data_source.dart';
import 'movie/data/models/boxoffice_movie_model.dart';
import 'movie/data/repositories/boxoffice_movie_repository.dart';
import 'movie/domain/usecases/boxoffice_movie_usecase.dart';

final boxofficeMoviesProvider = FutureProvider<List<BoxofficeMovieModel>> ((ref) async {
  ref.watch(checkInWatchListStateProvider);
  BoxofficeMovieRemoteDataSource boxofficeMovieRemoteDataSource = BoxofficeMovieRemoteDataSourceImpl();
  BoxofficeMovieRepository boxofficeMovieRepository = BoxofficeMovieRepositoryImpl(boxofficeMovieRemoteDataSource);
  final boxofficeMoviesList = await BoxofficeMovieUsecase(boxofficeMovieRepository).getBoxofficeMovies();
  return boxofficeMoviesList;
});

final rateProvider = Provider<RateUsecase>((ref) {
  RateLocalSource rateLocalSource = RateLocalSourceImpl(Hive.box('myMovies'));
  RateRepository rateRepository = RateRepositoryImpl(rateLocalSource);
  RateUsecase rateUsecase = RateUsecase(rateRepository);
  return rateUsecase;
});

/*
final watchListStateNotifierProvider = StateNotifierProvider<WatchListNotifier, List<BoxOfficeMovieListItem>>
  ((ref) => watchListNotifier());

class WatchListNotifier extends StateNotifier<List<BoxOfficeMovieListItem>> {
  WatchListNotifier(List<BoxOfficeMovieListItem> state) : super(state);

  void toggle(int movieId) {
    state =
  }

}*/

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
          Text('박스오피스'),
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