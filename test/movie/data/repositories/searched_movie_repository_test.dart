import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vwmdb/movie/data/datasources/searched_movie_remote_data_source.dart';
import 'package:vwmdb/movie/data/repositories/searched_movie_repository.dart';
import 'package:vwmdb/movie/domain/usecases/searched_movie_usecase.dart';

class MockRemoteDataSource extends Mock implements SearchedRemoteDatasource {}

void main() {

  SearchedMovieRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;
  SearchedRemoteDatasource? searchedRemoteDatasource;
  SearchedMovieUsecase? usecase;
  Dio? dio;
  Future<String>? testApiResult;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    searchedRemoteDatasource = SearchedRemoteDatasourceImpl();
    repository = SearchedMovieRepositoryImpl(searchedRemoteDatasource!);
    usecase = SearchedMovieUsecase(repository!);
    dio = Dio();
    testApiResult = Future.value('{"page":1,"results":[{"adult":false,"backdrop_path":"/kw4GhCZP5NeMVsfPol6HcX9JEeQ.jpg","genre_ids":[10770,28,12,14,878],"id":50468,"media_type":"movie","original_language":"en","original_title":"Dr. Strange","overview":"A psychiatrist becomes the new Sorcerer Supreme of the Earth in order to battle an evil Sorceress from the past.","popularity":180.152,"poster_path":"/uMoUh0cgZmAfbVF1aF9WGRfXKoh.jpg","release_date":"1978-09-06","title":"Dr. Strange","video":false,"vote_average":6.3,"vote_count":71},{"adult":false,"backdrop_path":"/eQN31P4IEhyp6NkdccvppJnyuJ4.jpg","genre_ids":[28,12,14,878],"id":284052,"media_type":"movie","original_language":"en","original_title":"Doctor Strange","overview":"After his career is destroyed, a brilliant but arrogant surgeon gets a new lease on life when a sorcerer takes him under her wing and trains him to defend the world against evil.","popularity":1051.599,"poster_path":"/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg","release_date":"2016-10-25","title":"Doctor Strange","video":false,"vote_average":7.4,"vote_count":19122},{"adult":false,"backdrop_path":"/aCoajX4hRgKbzCzIKgHLmk8TUp9.jpg","genre_ids":[27],"id":917514,"media_type":"movie","original_language":"en","original_title":"Doctor Carver","overview":"A group of ladies seeking the perfect faces soon realise when they conjure a demonic plastic surgeon, that no surgery comes without a price.","popularity":5.144,"poster_path":"/lThjsOJkc25dKOSFXevriNwSbeB.jpg","release_date":"2021-08-03","title":"Doctor Carver","video":false,"vote_average":2.7,"vote_count":3},{"adult":false,"backdrop_path":"/gUNRlH66yNDH3NQblYMIwgZXJ2u.jpg","genre_ids":[14,28,12],"id":453395,"media_type":"movie","original_language":"en","original_title":"Doctor Strange in the Multiverse of Madness","overview":"Doctor Strange, with the help of mystical allies both old and new, traverses the mind-bending and dangerous alternate realities of the Multiverse to confront a mysterious new adversary.","popularity":2382.939,"poster_path":"/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg","release_date":"2022-05-04","title":"Doctor Strange in the Multiverse of Madness","video":false,"vote_average":7.4,"vote_count":2175},{"adult":false,"backdrop_path":"/vy3uI3PCQWVnoW7OrKzB65Ba02c.jpg","genre_ids":[28,16,14,878],"id":14830,"media_type":"movie","original_language":"en","original_title":"Doctor Strange","overview":"Dr. Stephen Strange embarks on a wondrous journey to the heights of a Tibetan mountain, where he seeks healing at the feet of the mysterious Ancient One.","popularity":91.088,"poster_path":"/kP5ihakYGSTZ7FQDXBSbqla9men.jpg","release_date":"2007-08-14","title":"Doctor Strange","video":false,"vote_average":6.9,"vote_count":267},{"adult":false,"backdrop_path":"/sTp8K0SfcC2RQef1Tu160z3niHO.jpg","genre_ids":[18,35,10752],"id":935,"media_type":"movie","original_language":"en","original_title":"Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb","overview":"After the insane General Jack D. Ripper initiates a nuclear strike on the Soviet Union, a war room full of politicians, generals and a Russian diplomat all frantically try to stop the nuclear strike.","popularity":24.013,"poster_path":"/7SixLzxcqezkZEYU8pcHZgbkmjp.jpg","release_date":"1964-01-29","title":"Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb","video":false,"vote_average":8.1,"vote_count":4497}],"total_pages":1,"total_results":6}');
  });

  test('get searched movies api result', () async {
    String str = '닥터 스트레';
    var result = await dio!.get('https://api.themoviedb.org/3/search/multi?api_key=ebdee09f8577cf2e8727490069a1db3f&language=en-US&page=1&include_adult=false&query=${str}');
    print('${result}');
    str = 'doc';
    result = await dio!.get('https://api.themoviedb.org/3/search/multi?api_key=ebdee09f8577cf2e8727490069a1db3f&language=en-US&page=1&include_adult=false&query=${str}');
    print('\n${result}');
    str = 'doct';
    result = await dio!.get('https://api.themoviedb.org/3/search/multi?api_key=ebdee09f8577cf2e8727490069a1db3f&language=en-US&page=1&include_adult=false&query=${str}');
    print('\n${result}\n');
    str = 'doctxxxxx';
    result = await dio!.get('https://api.themoviedb.org/3/search/multi?api_key=ebdee09f8577cf2e8727490069a1db3f&language=en-US&page=1&include_adult=false&query=${str}');
    print('\n${result}\n');
  });

  test('검색어를 입력하면 결과를 리턴한다', () async {
    when(mockRemoteDataSource!.getSearchedResult('닥터 스트레'));

    final result = await repository!.getSearchedResult('닥터 스트레');

    verify(mockRemoteDataSource!.getSearchedResult('닥터 스트레'));
  });

  test('input 입력 후 result 반환 가능', () async {
    final res = await usecase!.getSearchedMovies('닥터 스트레');
    print(res);
  });
}