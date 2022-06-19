import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/viewmodels/rate/review_viewmodel.dart';

class ReviewPage extends ConsumerStatefulWidget {
  final movieId;

  ReviewPage(this.movieId);

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {

  late TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    print(ref.watch(reviewGetter(widget.movieId)));
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                padding: EdgeInsets.all(30),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    TextButton(onPressed: () {
                      ref.read(reviewSaver(Review(widget.movieId, textController.text)));
                      print(textController.text);
                      Navigator.pop(context);
                    }, child: Text('저장')),
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: '오늘은 당신의 기염둥이가 어떤 행동을 했나요?',
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  @override
  void initState() {
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
