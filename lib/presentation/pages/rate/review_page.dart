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
    AsyncValue<String?> savedResult = ref.watch(reviewGetter(widget.movieId));
    return savedResult.when(
        data: (data) {
          textController = TextEditingController(text: data);
          return Scaffold(
              body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      padding: EdgeInsets.all(30),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextButton(onPressed: () {
                              ref.read(reviewSaver(Review(widget.movieId,
                                  textController.text)));
                              print(textController.text);
                              Navigator.pop(context);
                            }, child: Text('저장')),
                            TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: '이 영화에 대한 감상을 남겨보세요',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
        }, loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text('${err}')
    );
  }
  //
  // @override
  // void initState() {
  //   textController = TextEditingController();
  // }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
