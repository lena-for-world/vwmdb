import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vwmdb/presentation/widgets/search/search_ing_list_widget.dart';

import '../../viewmodels/search/search_viewmodel.dart';
import '../../widgets/search/search_input_area_widget.dart';
import '../../widgets/search/search_ed_list_widget.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class SearchPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(searchState);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
              child:LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                height: constraints.maxHeight,
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      SearchInputArea(),
                      SizedBox(height: 30),
                      ref.read(searchState.state).state ? Text('검색하기') : Text('   최근 검색'),
                      SizedBox(height: 20),
                      Divider(thickness: 2,),
                      SizedBox(height: 20,),
                      Container(
                        height: constraints.maxHeight/5*3,
                        child:
                        //Expanded(child:
                        ref.read(searchState.state).state
                            ? SearchingList() : SearchedList(),
                        //),
                      ),
              ],
                  ),
            ),
                    );}),
        //}
      ),),
      ));//);
  }
}