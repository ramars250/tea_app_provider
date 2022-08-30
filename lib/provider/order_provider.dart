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
    if (n = null) {
      name = '';
    } else {
      name = n;
    }
    notifyListeners();
  }

  addTeaTitle(String t) {
    teaTitle = t;
    notifyListeners();
  }

  addCupSize(String c) {
    cupSize = c;
    notifyListeners();
  }

  addIce(String i) {
    ice = i;
    notifyListeners();
  }

  addSweet(String s) {
    sweet = s;
    notifyListeners();
  }

  addTeaPrice(int t) {
    teaPrice = t;
    notifyListeners();
  }

  addCupPrice(int c) {
    cupPrice = c;
    notifyListeners();
  }

  addTotalPrice() {
    totalPrice = (teaPrice + cupPrice) * qty;
    return totalPrice;
  }

  addQty() {
    qty += 1;
  }

  removeQty() {
    qty > 1 ? qty -= 1 : qty = 1;
  }

  resetQTY() {
    qty = 1;
  }
}
