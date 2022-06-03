import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:vwmdb/rate/data/datasources/rate_local_source.dart';
import 'package:vwmdb/rate/data/repositories/rate_repository.dart';
import 'package:vwmdb/rate/domain/usecases/rate_usecase.dart';

final starStateProvider = StateProvider<bool>((ref) => true);

final rateProvider = Provider<RateUsecase>((ref) {
  RateLocalSource rateLocalSource = RateLocalSourceImpl(Hive.box('myMovies'));
  RateRepository rateRepository = RateRepositoryImpl(rateLocalSource);
  RateUsecase rateUsecase = RateUsecase(rateRepository);
  return rateUsecase;
});


class StarsButton extends ConsumerWidget {

  final int movieId;

  StarsButton(this.movieId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(starStateProvider);
    double? starRated = ref.watch(rateProvider).getMovieRated(movieId);
    print('평가된 별점 : ${starRated}');
    return IconButton(
      icon: starRated == null ? Icon(Icons.star) : Icon(Icons.star),
      color: starRated == null ? Colors.white : Colors.yellow,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => StarRates(movieId),
        );
//        setState(() {});
      },
    );
  }
}

class StarRates extends ConsumerWidget {
  final int movieId;

  StarRates(this.movieId);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return AlertDialog(
        title: Text(
          '이 영화를 어떻게 보셨나요?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        titlePadding: EdgeInsets.only(top:12.0, left:12.0, right:12.0),
        contentPadding: EdgeInsets.all(0),
        content: Wrap(
          children:[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                _ratingBar(ref),
                SizedBox(height: 20.0),
              ]
            ),
          ]
        ),

    );
  }
  Widget _ratingBar(WidgetRef ref) {

    double? ratedStars = ref.watch(rateProvider).getMovieRated(movieId);

    return RatingBar.builder(
          // box에서 까서 가져오는걸로 바꿀 건데 일단 임의 데이터 넣어둠
          initialRating: ratedStars ?? 0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            if(rating > 0) {
              ref.read(rateProvider).saveMovieIfNotInLocalStore(movieId);
              ref.read(rateProvider).postMovieRating(movieId, rating);
              print(rating);
            } else {
              ref.read(rateProvider).deleteMovieRated(movieId);
              print(rating);
            }
            ref.read(starStateProvider.state).state = !ref.read(starStateProvider.state).state;
          },
          updateOnDrag: true,
    );
  }
}