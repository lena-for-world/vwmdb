import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwmdb/movie/data/models/boxoffice_movie_model.dart';
import 'package:vwmdb/rate/presentation/viewmodels/rate_viewmodel.dart';
import 'package:vwmdb/rate/presentation/widgets/rating_bar_widget.dart';
import '../../data/models/single_movie_model.dart';
import 'movie_detail_page.dart';
import '../viewmodels/movie_viewmodel.dart';

class BoxOfficeMovieListItem extends ConsumerWidget {

  final BoxofficeMovieModel boxofficeMovieModel;
  final int boxofficeRanking;
  final bool checkedIfInWatchList;

  BoxOfficeMovieListItem(this.boxofficeMovieModel, this.boxofficeRanking, this.checkedIfInWatchList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(starStateProvider);
    AsyncValue<SingleMovieModel> movieRatedByOthersModel = ref.watch(singleMovieProvider(boxofficeMovieModel.movieId));
    double movieRatedByOthers = movieRatedByOthersModel.when(
      data: (data) => data.voteAverage,
      loading: () => 0.0,
      error: (err, stack) => 0,
    );
    double? movieRatedByMe = ref.watch(rateProvider).getMovieRated(boxofficeMovieModel.movieId);
    return InkWell( // 누르면 영화 상세 페이지로 이동
    splashColor: Colors.white,
    highlightColor: Colors.black,
    child:Container(
      height: 360,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[800],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Stack(
              children: <Widget> [
                Container(
                  height: 230,
                  width: 170,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ClipRect(
                     child: Image.network('https://image.tmdb.org/t/p/w500${boxofficeMovieModel.poster}'),
                    )
                  ),
                  padding: EdgeInsets.all(10),
                ),
                IconButton (
                  icon: checkedIfInWatchList ? Icon(Icons.check) : Icon(Icons.add),
                  color: checkedIfInWatchList ? Colors.yellowAccent : Colors.white,
                  iconSize: 20,
                  onPressed: () {
                    // button toggle
                    // hive에 저장
                    ref.read(rateProvider).saveMovieIfNotInLocalStore(boxofficeMovieModel);
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
                  Text(
                      '${movieRatedByOthers}',
                      style: GoogleFonts.playfairDisplay(
                        fontSize:13,
                      )
                  ),
                  movieRatedByMe == null ? Text('') : Icon(Icons.star),
                  movieRatedByMe == null ? Text('') : Text('${movieRatedByMe*2}'),
                ]
            ),
            Expanded(
              child: Text(
                  '${boxofficeMovieModel.title}',
                  style: GoogleFonts.playfairDisplay(
                    fontSize:13,
                  ),
                textAlign: TextAlign.center,
              ),
            ),
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
