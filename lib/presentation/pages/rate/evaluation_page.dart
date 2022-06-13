import 'package:flutter/material.dart';

import '../../widgets/rate/evaluated_list_widget.dart';

class EvaluationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
        body:
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                padding: EdgeInsets.all(30),
                child: EvaluatedList(),
              );
            },
          ),
    );
  }
}