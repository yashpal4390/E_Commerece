// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../Controller/Provider/product_provider.dart';
import '../Modal/product_modal.dart';
import '../View/cart_page.dart';

class DetailsPage extends StatefulWidget {
  final String? title;
  final String? description;
  final String? image;
  final String? category;
  final double? rating;
  final double? price;

  const DetailsPage({
    Key? key,
    required this.title,
    required this.rating,
    required this.image,
    required this.category,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartPage();
                }));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              child: Image.network(
                "${widget.image}",
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  RatingBarIndicator(
                    rating: widget.rating ?? 0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        widget.category?.split('.').last ?? "",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.price}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Consumer<ProductProvider>(
                        builder: (BuildContext context, ProductProvider value,
                            Widget? child) {
                          return ElevatedButton(
                            onPressed: () {
                              Product product = Product(
                                quantity: value.quantity,
                                title: widget.title,
                                price: widget.price,
                                image: widget.image,
                              );

                              bool alreadyInCart = Provider.of<ProductProvider>(
                                context,
                                listen: false,
                              )
                                  .cartList
                                  .any((item) => item.title == product.title);
                              if (alreadyInCart) {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .cartList
                                    .where(
                                        (item) => item.title == product.title)
                                    .forEach((item) => item.quantity =
                                        (item.quantity ?? 0) +
                                            1); // Increment quantity
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .saveData();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CartPage();
                                }));
                                print("Item quantity incremented in the cart");
                                final snackBar = SnackBar(
                                  content: Text(
                                      'Item quantity incremented in the cart'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                print(product.toJson());
                                var pp = Provider.of<ProductProvider>(context,
                                    listen: false);
                                pp.cartList.add(product);
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .saveData();
                                final snackBar = SnackBar(
                                  content: Text('Item Added in the cart'),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'View Cart',
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CartPage();
                                      }));
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                print("Item added to cart");
                              }
                              var pp = Provider.of<ProductProvider>(context,
                                  listen: false);
                              print("${pp.cartList.length}");
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrangeAccent,
                            ),
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
