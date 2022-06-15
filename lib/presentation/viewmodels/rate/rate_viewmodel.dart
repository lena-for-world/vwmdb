import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../data/datasources/rate/rate_local_source.dart';
import '../../../data/repositories/rate/rate_repository.dart';
import '../../../domain/usecases/rate/rate_usecase.dart';

// 한 아이템 당 하나의 프로바이더가 적용되는가? => ㄴㄴ ㅋㅋ
// family 사용은 좋은 대안이 아닌 듯함
// 기본값이 true로 설정되는가? => 그렇다면 어떻게 할 지 고민하기...? 고민필요한가?  ==> ㅋㅋ ㅇㅇ
// true면 여기에 기반해서 변경을 감지하나...? ==> ㅋㅋ ㅇㅇ
// 영화 하나가 토글될때마다 상태가 변하는데, 이 프로바이더를 모든 영화들이 공유하기 때문에
// int 증가 방식으로 변화를 체크했음
// bool 방식으로 상태변화를 체크할 수 없었음 상태가 고작 2가지라서
final checkInWatchListStateProvider = StateProvider.autoDispose<int>((ref) => 0);

final rateProvider = Provider.autoDispose<RateUsecase>((ref) {
  RateLocalSource rateLocalSource = RateLocalSourceImpl(Hive.box('myMovies'));
  RateRepository rateRepository = RateRepositoryImpl(rateLocalSource);
  RateUsecase rateUsecase = RateUsecase(rateRepository);
  return rateUsecase;
});