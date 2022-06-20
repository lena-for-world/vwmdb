import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwmdb/presentation/viewmodels/movie/movie_viewmodel.dart';
import 'package:vwmdb/presentation/widgets/movie/latest_movie_carousel_widget.dart';
import 'package:vwmdb/presentation/widgets/movie/boxoffice_movie_list_widget.dart';

class RankingMoviesPage extends ConsumerWidget {
  Future<void> _testingRefresh(WidgetRef ref) async {
    print('test refresh');
    // ref.refresh(latestMoviesProvider);
    // ref.refresh(boxofficeMoviesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                      height: constraints.maxHeight,
                      color: Colors.white,
                      child: RefreshIndicator(
                        onRefresh: () => _testingRefresh(ref),
                        child: ListView(
                          children: [
                            Container(
                              height: (constraints.maxHeight/7)*3.2,
                              child: LatestMoviesCarouselWidget(),
                            ),
                            Container(
                              height: constraints.maxHeight/7*0.4,
                              child: Align(alignment: Alignment.centerLeft, child: Text('Hot Movies', style: GoogleFonts.pressStart2p(), textAlign: TextAlign.center),),
                            ),
                            Container(
                              height: (constraints.maxHeight/7)*3.4,
                              child: BoxOfficeList(),
                            ),
                          ],
                  ),
                      ),
                );}
            ),
        )
      );
  }
}