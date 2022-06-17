import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/widgets/rate/watch_list_item_widget.dart';
import '../../viewmodels/movie/movie_viewmodel.dart';
import '../../viewmodels/rate/rate_viewmodel.dart';
import '../../viewmodels/rate/watchlist_viewmodel.dart';

class WatchList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(checkInWatchListStateProvider);
    List<WatchListItem> resultList = [];
    List<int> inWatchLists = ref.watch(moviesInWatchlistProvider);
    inWatchLists.forEach((element) {
      // read일때는 boxoffice에 안 들어있는 영화들에 대해서는 바로 못읽어오고 로딩상태이다가,
      // 텀을 좀 두고 들어가면 영화가 표출됨
      // watch로 변경하면 텀 안 두고 바로 들어가도 내가 나중에 볼 영화로 등록해놓은 모든 영화들이 표출됨
      // 콜백 상황 또는 빌드 리턴 내부가 아닌 모든 경우에 꼭 watch를 사용해야할 이유가 되는 것 같은데, 이유가 궁금함
      var fetchedResult = ref.watch(singleMovieProvider(element));
      fetchedResult.when(
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