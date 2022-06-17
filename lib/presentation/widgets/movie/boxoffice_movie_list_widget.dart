import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vwmdb/presentation/viewmodels/movie/movie_viewmodel.dart';

import '../../../data/models/movie/boxoffice_movie_model.dart';
import '../../viewmodels/rate/watchlist_viewmodel.dart';
import 'boxoffice_movie_list_item_widget.dart';

class BoxOfficeList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
                bool isInWatchList = ref.read(ifInWatchListProvider(data[index].movieId));
                return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    child: BoxOfficeListItem(data[index], index, isInWatchList),
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