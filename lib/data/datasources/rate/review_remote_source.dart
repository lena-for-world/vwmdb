import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../../../core/network/me.dart';
import '../../models/rate/review_model.dart';

abstract class ReviewRemoteSource {
  void saveReview(int movieId, String review);
//  void deleteReview(int movieId);
  Future<String?> getReview(int movieId);
  Future<List<ReviewModel>> getReviewAll();
  //void updateReview(int movieId, String review);
}

class ReviewRemoteSourceImpl implements ReviewRemoteSource {

  final ref = FirebaseDatabase.instance.ref();

  @override
  Future<String?> getReview(int movieId) async {
    final snapshot = await ref.child('${uuid}/${movieId}/review').get();
    if(snapshot.exists) {
      return snapshot.value.toString();
    }
  }

  @override
  void saveReview(int movieId, String review) async {
    final ref = FirebaseDatabase.instance.ref('${uuid}/${movieId}');
    await ref.set({
      "review": review,
    });
  }

  @override
  Future<List<ReviewModel>> getReviewAll() async {
    List<ReviewModel> reviewModels = [];
    await ref.child('${uuid}').get().then((val) {
      print(val.key);
      print(val.value);
      print(val.value.runtimeType);
      Map<String, dynamic> res = json.decode(json.encode(val.value));
      res.forEach((key, value) {
        reviewModels.add(ReviewModel.fromJson(int.parse(key), value['review']));
      });
    });
    return reviewModels;
  }
}