import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/viewmodels/rate/review_viewmodel.dart';
import 'package:vwmdb/presentation/widgets/rate/review_list_item_widget.dart';

import '../../../data/models/rate/review_model.dart';

class ReviewList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<ReviewModel>> reviewList = ref.watch(reviewListGetter);
    return reviewList.when(
        data: (reviewList) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: reviewList.length,
            itemBuilder: (context, index) =>
                Container(
                  child: ReviewListItem(reviewList[index]), //, ratedList.length~/3),
                ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('err'),
    );
  }
}