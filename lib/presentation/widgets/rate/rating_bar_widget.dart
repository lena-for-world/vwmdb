import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../viewmodels/rate/rate_viewmodel.dart';

final starStateProvider = StateProvider<bool>((ref) => true);

class StarsButton extends ConsumerWidget {

  final Movie movie;

  StarsButton(this.movie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(starStateProvider);
    double? starRated = ref.watch(ratedStarsProvider(movie.movieId));
    return IconButton(
      icon: starRated == null ? Icon(Icons.star) : Icon(Icons.star),
      color: starRated == null ? Colors.white : Colors.yellow,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
                return Container(child: StarRates(movie), width: constraints.maxWidth/3,);
            }),
        );
      },
    );
  }
}

class StarRates extends ConsumerWidget {

  final Movie movie;

  StarRates(this.movie);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
          width: constraints.maxWidth/2,
            child: AlertDialog(
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
    ),);}
    );
  }
  Widget _ratingBar(WidgetRef ref) {

    double? ratedStars = ref.watch(ratedStarsProvider(movie.movieId));

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
              ref.read(postMovieRatingProvider(RateSaver(movie, rating)));
              print(rating);
            } else {
              ref.read(deleteMovieRatingProvider(movie.movieId));
              print(rating);
            }
            ref.read(starStateProvider.state).state = !ref.read(starStateProvider.state).state;
          },
          updateOnDrag: true,
    );
  }
}