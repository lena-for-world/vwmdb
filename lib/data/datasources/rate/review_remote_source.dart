import 'package:firebase_database/firebase_database.dart';

import '../../../core/network/me.dart';

abstract class ReviewRemoteSource {
  void saveReview(int movieId, String review);
//  void deleteReview(int movieId);
  String getReview(int movieId);
  //void updateReview(int movieId, String review);
}

class ReviewRemoteSourceImpl implements ReviewRemoteSource {

  DatabaseReference ref = FirebaseDatabase.instance.ref(uuid);

  @override
  String getReview(int movieId) {
    String data = '';
    ref = FirebaseDatabase.instance.ref('${uuid}/${movieId}/review');
    ref.onValue.listen((DatabaseEvent event) {
      data = event.snapshot.value.toString();
      print('get ${data}');
    });
    print('get 22 ${data}');
    return data;
  }

  @override
  void saveReview(int movieId, String review) async {
    ref = FirebaseDatabase.instance.ref('${uuid}/${movieId}');
    await ref.set({
      "review": review,
    });
  }

  // @override
  // void updateReview(int movieId, String review) async {
  //   // TODO: implement updateReview
  //   await ref.update({
  //     movieId: review,
  //   });
  // }

}