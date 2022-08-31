import 'package:flutter/cupertino.dart';
import 'package:tea_app/json_service/get_tea_json.dart';
import 'package:tea_app/model/tea_model.dart';

class TeaProvider extends ChangeNotifier {
  TeaList teaData;
  TeaData isSelected;
  Item selected;

  getTeaData() async {
    teaData = await loadingTeaJsonData();
    notifyListeners();
  }

  setTeaDataSelected(TeaData teaData) {
    isSelected = teaData;
  }

  setItemSelected(Item item) {
    selected = item;
  }
}
