// ignore_for_file: avoid_print
import 'package:advanced_exam/Modal/product_modal.dart';
import 'package:advanced_exam/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiHelper extends ChangeNotifier{

  static ApiHelper obj = ApiHelper._();

  ApiHelper._();
  factory ApiHelper() {
    return obj;
  }

  void getApiData() async {
    var future = await http.get(
        Uri.parse("https://fakestoreapi.com/products"));
    productList = productFromJson(future.body);
    notifyListeners();
  }
}
