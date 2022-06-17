import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/movie/single_movie_model.dart';
import '../../pages/movie/movie_detail_page.dart';
import '../../viewmodels/rate/rate_viewmodel.dart';

class WatchListItem extends ConsumerWidget {

  SingleMovieModel singleMovie;
  WatchListItem(this.singleMovie);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: <Widget> [
        TextButton(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget> [
                Container(
                  width: 140,
                  height: 180,
                  child: Image.network('https://image.tmdb.org/t/p/w500/${singleMovie.poster}',
                  cacheWidth: 300,
                    cacheHeight: 360,
                  ),
                ),
                SizedBox(height: 10),
                Text('${singleMovie.title}'),
              ],
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder:
                (context) => SingleMoviePage(singleMovie.movieId)
            )
            );
          },
        ),
        IconButton (
          icon: Icon(Icons.check),
          iconSize: 20,
          onPressed: () {
            ref.read(postMovieToWatchListProvider(singleMovie));
            ref.read(checkInWatchListStateProvider.state).state++;
          },
        )
      ],
    );
  }
}