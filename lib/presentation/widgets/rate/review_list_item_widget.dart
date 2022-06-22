import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/data/models/movie/single_movie_model.dart';
import 'package:vwmdb/presentation/viewmodels/movie/movie_viewmodel.dart';

import '../../../data/models/rate/review_model.dart';

class ReviewListItem extends ConsumerWidget{
  ReviewModel reviewModel;

  ReviewListItem(this.reviewModel);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(singleMovieViewModelProvider).getSingleMovie(reviewModel.movieId);
    // AsyncValue<SingleMovieModel> movie = ref.watch(singleMovieViewModelProvider).singleMovie;// ref.watch(singleMovieProvider(reviewModel.movieId));
    AsyncValue<SingleMovieModel> movie = ref.watch(singleMovieProvider(reviewModel.movieId));
    return movie.when(data: (movie) {
      return ListTile(
        title: Text(movie.title),
        trailing: Text(reviewModel.content),
      );
    },
    loading: () => Center(child: CircularProgressIndicator()),
    error: (err, stack) => Text('err'),
    );
  }

}