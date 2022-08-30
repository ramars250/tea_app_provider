import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  String name;
  String teaTitle;
  String cupSize;
  String ice;
  String sweet;
  String feed;
  int qty = 1;
  int totalPrice;
  int teaPrice;
  int cupPrice = 0;
  int feedPrice;

  addName(String n) {
    if (n != null) {
      name = n;
    } else {
      name = '';
    }
  }

  addTeaTitle(String t) {
    teaTitle = t;
  }

  addCupSize(String c) {
    cupSize = c;
  }

  addIce(String i) {
    ice = i;
  }

  addSweet(String s) {
    sweet = s;
  }

  addTeaPrice(int t) {
    teaPrice = t;
  }

  addCupPrice(int c) {
    cupPrice = c;
  }

  addTotalPrice() {
    totalPrice = teaPrice;
    notifyListeners();
  }
  addQty() {
    qty += 1;
  }
  removeQty() {
    qty > 1 ? qty -= 1 : qty = 1;
  }
}
