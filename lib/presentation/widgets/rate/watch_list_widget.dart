import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/widgets/rate/watch_list_item_widget.dart';
import '../../viewmodels/movie/movie_viewmodel.dart';
import '../../viewmodels/rate/rate_viewmodel.dart';

class WatchList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(checkInWatchListStateProvider);
    List<WatchListItem> resultList = [];
    List<int> inWatchLists = ref.watch(rateProvider).checkAllMoviesIfInWatchList();
    inWatchLists.forEach((element) {
      var res = ref.read(singleMovieProvider(element));
      res.when(
        data: (data) {
          resultList.add(WatchListItem(data));
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => [err],
      );
    });
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: resultList.length,
      itemBuilder: (BuildContext context, int index) {
        return resultList[index];
      },
    );
  }
}