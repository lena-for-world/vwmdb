// single movie get repository code
// with mock data source

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vwmdb/movie/data/datasources/single_movie_remote_data_source.dart';
import 'package:vwmdb/movie/data/models/single_movie_model.dart';
import 'package:vwmdb/movie/data/repositories/single_movie_repository.dart';

class MockSingleRemoteDataSource extends Mock implements SingleMovieRemoteDataSource {}

void main() {

  SingleMovieRemoteDataSource? singleRemoteDataSource;
  SingleMovieRepository? singleMovieRepository;

  setUp(() {
    singleRemoteDataSource = SingleMovieRemoteDataSourceImpl();
    singleMovieRepository = SingleMovieRepositoryImpl(
      singleRemoteDataSource!
    );
  });

  test('single movie detail을 가져와서 SingleMovieModel을 반환한다', () async {
   // when(mockSingleRemoteDataSource!.getSingleMovieDetail(284052));

    final result = await singleMovieRepository!.getSingleMovieDetail(284052);
    //verify(mockSingleRemoteDataSource!.getSingleMovieDetail(284052));
  });
}