// ignore_for_file: prefer_const_constructors
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
              height: 740,
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
                      : Center(
                          child: Text("YOUR CART LIST IS EMPTY"),
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
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text("TOTAL  \$$totalString ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
