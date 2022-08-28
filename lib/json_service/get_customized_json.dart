//解析customized.json資料
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tea_app/model/customer_model.dart';

Future<CustomerList> loadingCustomeJsonData() async {
  CustomerList customerData;
  String jsonData =
  await rootBundle.loadString('assets/json/customized.json');
  final jsonResponse = json.decode(jsonData);
  customerData = CustomerList.fromJson(jsonResponse);
  // print(customerData.cData[0].iceCubes);
  // setState(() {
  //   this.cData = customerData.cData;
  // });
  return customerData;
}