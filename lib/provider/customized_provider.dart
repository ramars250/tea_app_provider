import 'package:flutter/cupertino.dart';
import 'package:tea_app/json_service/get_customized_json.dart';
import 'package:tea_app/model/customer_model.dart';

class CustomizedProvider extends ChangeNotifier {
  CustomerList customerList;
  Feed isSelected;

  getCustomerData() async {
    customerList = await loadingCustomeJsonData();
    notifyListeners();
  }

  setFeedSelected(Feed feed) {
    isSelected = feed;
  }
}
