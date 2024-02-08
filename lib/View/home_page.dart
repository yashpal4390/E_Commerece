// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:advanced_exam/util.dart';
import 'package:flutter/material.dart';

import '../Modal/api_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    ApiHelper().getApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Title"),
          centerTitle: true,
        ),
        body: SizedBox(
          height: deviceHeight / 1,
          child: GridView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var sample = productList[index];
              return Container(
                height: deviceHeight / 5,
                child: Column(
                  children: [
                    Text("${sample.title}"),
                    Image.network(sample.image!),
                  ],
                )
              );
            }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ));
  }
}
