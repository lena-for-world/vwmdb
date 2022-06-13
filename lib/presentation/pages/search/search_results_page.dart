import 'package:flutter/material.dart';

import '../../widgets/search/search_results_list_widget.dart';

class SearchResultsPage extends StatelessWidget {

  String input;

  SearchResultsPage(this.input);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SearchedResultsList(input),
      ),
    );
  }
}