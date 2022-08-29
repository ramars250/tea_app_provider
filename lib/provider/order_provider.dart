import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  String name;
  String teaTitle;
  String cupSize;
  String ice;
  String sweet;
  String feed;
  int qty;
  int totalPrice;
  int teaPrice;
  int cupPrice;
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

}
