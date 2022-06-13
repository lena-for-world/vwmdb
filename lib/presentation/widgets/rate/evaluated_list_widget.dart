import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/viewmodels/rate/rate_viewmodel.dart';

import '../../../data/models/rate/rate_model.dart';
import 'evaluated_list_item_maker_widget.dart';

class EvaluatedList extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<RateModel> ratedList = ref.watch(rateProvider).checkAllMoviesIfInRatedList();
    var size = MediaQuery.of(context).size;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: ratedList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: (size.width/3) / ((size.height - 30) / 3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => Container(
        child: EvaluatedListItem(ratedList[index]),//, ratedList.length~/3),
      ),
    );
  }
}