// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:advanced_exam/View/detail_page.dart';
import 'package:advanced_exam/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailsPage(
                      title: sample.title,
                      category: "${sample.category}",
                      description: sample.description,
                      image: sample.image,
                      price: sample.price,
                      rating: double.parse("${sample.rating!.rate}"),
                    );
                  },));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  color: Colors.grey,
                    height: deviceHeight / 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          sample.image!,
                          height: 100,
                          width: 100,
                        ),
                        Text("${sample.title}",maxLines: 2,overflow: TextOverflow.ellipsis),
                        Text("\$${sample.price}"),
                        RatingBarIndicator(
                          rating: double.parse("${sample.rating!.rate}"),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 11.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    )),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ));
  }
}
