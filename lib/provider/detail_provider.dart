import 'package:flutter/material.dart';
import 'package:tea_app/model/detail_model.dart';

class DetailProvider extends ChangeNotifier {
  List<DetailItems> _detailItems = [];
  DetailItems _avtiveItem = null;

  List<DetailItems> get items {
    return _detailItems;
  }

  DetailItems get avtiveItem {
    return _avtiveItem;
  }

  setActiveItem(DetailItems i) {
    _avtiveItem = i;
  }

}
