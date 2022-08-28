//解析tea.json資料
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tea_app/model/tea_model.dart';

Future<TeaList> loadingTeaJsonData() async {
  TeaList teaData;
  // 設字串變數listJson等於本地json內容
  String jsonData = await rootBundle.loadString('assets/json/tea.json');
  //設變數jsonResponse為json解碼後的內容
  final jsonResponse = json.decode(jsonData);
  //設TeaList的類型為list的teaData為TeaList反序列化的內容
  teaData = TeaList.fromJson(jsonResponse);
  //更新狀態，將teaData.teaData的反序列化內容指定給先前建立的data列表，方便需要使用的時候可用
  return teaData;
}