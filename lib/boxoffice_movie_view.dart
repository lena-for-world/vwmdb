import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/movie/data/models/boxoffice_movie_model.dart';
import 'package:vwmdb/v_main_page.dart';

// 한 아이템 당 하나의 프로바이더가 적용되는가? => ㄴㄴ ㅋㅋ
// family 사용은 좋은 대안이 아닌 듯함
// 기본값이 true로 설정되는가? => 그렇다면 어떻게 할 지 고민하기...? 고민필요한가?  ==> ㅋㅋ ㅇㅇ
// true면 여기에 기반해서 변경을 감지하나...? ==> ㅋㅋ ㅇㅇ
final checkInWatchListStateProvider = StateProvider<bool>((ref) => false);

class BoxOfficeMovieListItem extends ConsumerWidget {

  final BoxofficeMovieModel boxofficeMovieModel;
  final int boxofficeRanking;
  bool checkedIfInWatchList;

  BoxOfficeMovieListItem(this.boxofficeMovieModel, this.boxofficeRanking, this.checkedIfInWatchList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    checkedIfInWatchList = ref.watch(checkInWatchListStateProvider);
    return Container(
      height: 300,
      width: 170,
      color: Colors.grey,
      child: Column(
          children: <Widget> [
            Stack(
              children: <Widget> [
                Container(
                  height: 220,
                  width: 170,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network('https://image.tmdb.org/t/p/w500/${boxofficeMovieModel.poster}'),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                IconButton (
                  icon: checkedIfInWatchList ? Icon(Icons.check) : Icon(Icons.add),
                  iconSize: 20,
                  onPressed: () {
                    // button toggle
                    // hive에 저장
                    ref.read(checkInWatchListStateProvider.state).state = !checkedIfInWatchList;
                    ref.read(rateProvider).postCheckOrUncheckMovieInWatchList(boxofficeMovieModel.movieId);
                  },
                )
              ],
            ),
            Text('${boxofficeRanking+1}'),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Icon(Icons.star),
                  Text('stars'),
                  Icon(Icons.star_border),
                  Text('stars'),
                ]
            ),
            Text('${boxofficeMovieModel.title}'),
          ]
      ),
    );
  }
}
