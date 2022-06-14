import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              height: constraints.maxHeight,
              child:Column(
                  children:[
                    Text('Hello, World!'),
                    Text('Hello, World!'),Text('Hello, World!'),Text('Hello, World!'),Text('Hello, World!'),Text('Hello, World!'),
                    SizedBox(height: 20,),
                    Container(
                      height: constraints.maxHeight/2,
                      child: SingleChildScrollView(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                      Container(child:Text('Hello, World!')),Container(child:Text('Hello, World!')),
                          Container(
                              child:Text('Hello, World!')),
                          Container(
                              child:Text('Hello, World!')),
                        ],
                      ),),
                    )
                  ]
              ));});
  }
}
