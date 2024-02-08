// ignore_for_file: prefer_const_constructors

import 'package:advanced_exam/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Modal/product_modal.dart';

class DetailsPage extends StatefulWidget {
  String? title;
  String? description;
  String? image;
  String? category;
  double? rating;
  double? price;

  DetailsPage({
    Key? key,
    required this.title,
    required this.rating,
    required this.image,
    required this.category,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Image.network(
              "${widget.image}",
              width: 307,
              height: 390,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: MediaQuery.sizeOf(context).height * 0.37,
            width: MediaQuery.sizeOf(context).width * 0.95,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Text(
                  "${widget.title}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                RatingBarIndicator(
                  rating: double.parse("${widget.rating}"),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  "Description:-",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 7),
                Text(
                  widget.description ?? "",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Category:- ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        widget.category ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(18)),
                  margin: EdgeInsets.all(40),
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "\$${widget.price}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Product product = Product(
                              title: widget.title,
                              price: widget.price,
                              image: widget.image,
                            );
                            if(cartList.contains(product)){
                              print("Already");
                            }
                            else{
                              cartList.add(product);
                            }
                            print(cartList.length);
                          }, child: Text("Add to Cart"))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
