import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/movie/data/models/boxoffice_movie_model.dart';
import 'package:vwmdb/v_main_page.dart';

import 'movie_detail_page.dart';

// 한 아이템 당 하나의 프로바이더가 적용되는가? => ㄴㄴ ㅋㅋ
// family 사용은 좋은 대안이 아닌 듯함
// 기본값이 true로 설정되는가? => 그렇다면 어떻게 할 지 고민하기...? 고민필요한가?  ==> ㅋㅋ ㅇㅇ
// true면 여기에 기반해서 변경을 감지하나...? ==> ㅋㅋ ㅇㅇ
// 영화 하나가 토글될때마다 상태가 변하는데, 이 프로바이더를 모든 영화들이 공유하기 때문에
// int 증가 방식으로 변화를 체크했음
// bool 방식으로 상태변화를 체크할 수 없었음 상태가 고작 2가지라서
final checkInWatchListStateProvider = StateProvider<int>((ref) => 0);

class BoxOfficeMovieListItem extends ConsumerWidget {

  final BoxofficeMovieModel boxofficeMovieModel;
  final int boxofficeRanking;
  final bool checkedIfInWatchList;

  BoxOfficeMovieListItem(this.boxofficeMovieModel, this.boxofficeRanking, this.checkedIfInWatchList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//    checkedIfInWatchList = ref.watch(checkInWatchListStateProvider);
    return InkWell( // 누르면 영화 상세 페이지로 이동
    splashColor: Colors.white,
    highlightColor: Colors.black,
    child:Container(
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
                    child: Image.network('https://image.tmdb.org/t/p/w500${boxofficeMovieModel.poster}'),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                IconButton (
                  icon: checkedIfInWatchList ? Icon(Icons.check) : Icon(Icons.add),
                  iconSize: 20,
                  onPressed: () {
                    // button toggle
                    // hive에 저장
                    ref.read(rateProvider).saveMovieIfNotInLocalStore(boxofficeMovieModel.movieId);
                    ref.read(rateProvider).postCheckOrUncheckMovieInWatchList(boxofficeMovieModel.movieId);
                    ref.read(checkInWatchListStateProvider.state).state++; // int 증가로 리스트 변경하기, 아이콘은 리스트 재빌드되면서 알아서 잘 들어갈거라 변경해도 상관없음
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
    ), onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder:
          (context) => SingleMoviePage(boxofficeMovieModel.movieId)
        )
      );
    }
    );
  }
}
