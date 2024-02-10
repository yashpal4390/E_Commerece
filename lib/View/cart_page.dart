// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/Provider/product_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CART PAGE"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height/1.3,
              child: Consumer<ProductProvider>(
                builder: (BuildContext context, ProductProvider value,
                    Widget? child) {
                  return (value.cartList.isNotEmpty)
                      ? ListView.builder(
                          itemCount: value.cartList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image.network(
                                      "${value.cartList[index].image}"),
                                  title: Text("${value.cartList[index].title}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Price: ${value.cartList[index].price}"),
                                      Consumer<ProductProvider>(
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return Row(
                                            children: [
                                              Text("Quantity: "),
                                              IconButton(
                                                onPressed: () {
                                                  value.remove(index);
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                              Text(
                                                  "${value.cartList[index].quantity ?? 0}"),
                                              IconButton(
                                                onPressed: () {
                                                  value.add(index);
                                                },
                                                icon: Icon(Icons.add),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    value.delete(index);
                                                  },
                                                  icon: Icon(Icons.delete)),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_shopping_cart_outlined, size: 100),
                            Center(
                              child: Text(
                                "YOUR CART LIST IS EMPTY",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Looks Like You have not added anything to your cart!.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                " Go Ahead and explore top categories.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        );
                },
              ),
            ),
            Consumer<ProductProvider>(
              builder: (BuildContext context, value, Widget? child) {
                double total = 0;
                for (var item in value.cartList) {
                  total += (item.price ?? 0) * (item.quantity ?? 0);
                }
                String totalString = total.toStringAsFixed(2);
                return (value.cartList.isNotEmpty)
                    ? Container(
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "TOTAL  \$$totalString",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )

                    : SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
