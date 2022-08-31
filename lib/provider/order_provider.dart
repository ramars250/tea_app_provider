import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  String name;
  String teaTitle;
  String cupSize;
  String ice;
  String sweet;
  List<String> feedTitle = [];
  int qty = 1;
  int totalPrice;
  int teaPrice;
  int cupPrice = 0;
  int cupId;
  int iceId;
  int sweetId;
  int feedId;
  List<int> selectedFeed = [];
  List<int> feedPrice = [];

  addCupId(int i) {
    cupId = i;
  }

  addIceId(int i) {
    iceId = i;
  }

  addSweetId(int i) {
    sweetId = i;
  }

  addFeedId(int i) {
    feedId = i;
  }

  addSelectedFeed(int i) {
    selectedFeed.contains(i) ? selectedFeed.remove(i) : selectedFeed.add(i);
    selectedFeed.length > 2 ? selectedFeed.clear() : selectedFeed.length;
  }

  addFeedPrice(int i) {
    feedPrice.contains(i) ? feedPrice.remove(i) : feedPrice.add(i);
  }

  addFeedTitle(String f) {
    feedTitle.contains(f) ? feedTitle.remove(f) : feedTitle.add(f);
  }

  resetAll() {
    cupId = null;
    iceId = null;
    sweetId = null;
    feedId = null;
    selectedFeed = [];
    feedPrice = [];
    // feedTitle = [];
    qty = 1;
  }

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
    totalPrice = (teaPrice + cupPrice) * qty;
    return totalPrice;
  }

  addQty() {
    qty += 1;
  }

  removeQty() {
    qty > 1 ? qty -= 1 : qty = 1;
  }
}
