import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TeaDataModel extends ChangeNotifier {
  Map<String, dynamic> _map = {};

  Map<String, dynamic> get map => _map;

  Future<void> get fetchData async {
    final response = await rootBundle.loadString('assets/json/tea.json');
    if (response != null) {
      _map = json.decode(response);
    }
    notifyListeners();
  }
}
