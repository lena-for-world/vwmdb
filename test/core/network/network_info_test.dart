/*import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:vwmdb/core/network/network_info.dart';*/
/*
class MockDataConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  NetworkInfoImpl? networkInfo;
  MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker!);
  });

  group('isConnected', ()
  {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
          () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(await mockDataConnectionChecker!.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture.value);
        // act
        // NOTICE: We're NOT awaiting the result
        final result = networkInfo!.isConnected;
        // assert
        verify(mockDataConnectionChecker!.hasConnection);
        // Utilizing Dart's default referential equality.
        // Only references to the same object are equal.
        expect(result, tHasConnectionFuture);
      },
    );
  });
}*/