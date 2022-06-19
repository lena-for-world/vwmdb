import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vwmdb/data/datasources/rate/review_remote_source.dart';
import 'package:vwmdb/data/repositories/rate/review_repository.dart';
import 'package:vwmdb/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ReviewRepository? reviewRepository;
  ReviewRemoteSourceImpl remoteSource;

  setUp(() {
    remoteSource = new ReviewRemoteSourceImpl();
    reviewRepository = new ReviewRepositoryImpl(remoteSource);
  });

  test('save review test', () {
    reviewRepository!.saveReview(123, "이 영화 진심 개구림 다시는 안 보고 싶음");
  });
}