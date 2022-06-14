import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/movie/latest_movie_model.dart';
import '../../viewmodels/movie/movie_viewmodel.dart';
import 'latest_movie_item_maker_widget.dart';

class LatestMoviesCarouselWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AsyncValue<List<LatestMovieModel>> latestMovieModelList = ref.watch(latestMoviesProvider);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            // carouselslider는 list<widget>을 받게 되어있음!
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
                viewportFraction: 1,
              ),
              items: ImageSlider(latestMovieModelList).giveWidgets(),
            ),
          );
        });
  }
}