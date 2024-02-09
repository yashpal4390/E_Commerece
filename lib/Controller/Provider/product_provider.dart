// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:advanced_exam/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Modal/product_modal.dart';
import '../../util.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productList = [];
  List<Product> cartList=[];
  String cartListJson = "";

  void fetchProducts() async {
    var future = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    productList = productFromJson(future.body);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void remove(int index) {
    if (cartList[index].quantity != null && cartList[index].quantity! > 1) {
      cartList[index].quantity = cartList[index].quantity! - 1;
      notifyListeners();
    }
    notifyListeners();
  }

  void add(int index) {
    cartList[index].quantity = (cartList[index].quantity ?? 0) + 1;
    notifyListeners();
  }

  void delete(int index) {
    if (index >= 0 && index < cartList.length) {
      cartList.removeAt(index);
      notifyListeners();
    } else {
      print("Invalid index: $index");
    }
  }

  void saveData() {
    cartListJson =
        jsonEncode(cartList.map((product) => product.toJson()).toList());
    prefs.setString("cart", cartListJson);
    print("SAVED LOCALLY");
    notifyListeners();
  }

  void getData() async {
    print("GET DATA FROM LOCAL");
    prefs = await SharedPreferences.getInstance(); // Obtain SharedPreferences instance
    String? cartListJson = prefs.getString('cart');
    if (cartListJson != null) {
      List<dynamic> decodedList = jsonDecode(cartListJson);
      cartList = decodedList.map((json) => Product.fromJson(json)).toList();
      print(cartList.length);
    }
    notifyListeners();
  }

}
