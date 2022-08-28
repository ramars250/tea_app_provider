class TeaList {
  List<TeaData> teaData;

  TeaList({this.teaData});

  factory TeaList.fromJson(Map<String, dynamic> json) {
    var list = json['tea_data'] as List;
    List<TeaData> data = list.map((e) => TeaData.fromJson(e)).toList();
    return TeaList(teaData: data);
  }
}

class TeaData {
  String kindTitle;
  List<Item> items;

  TeaData({this.kindTitle, this.items});

  factory TeaData.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> items = list.map((e) => Item.fromJson(e)).toList();
    return TeaData(kindTitle: json['kind_title'], items: items);
  }
}

class Item {
  String itemTitle;
  List<String> size;
  int bPrice;
  int coldPrice;
  int hotPrice;

  Item({this.itemTitle, this.size, this.bPrice, this.coldPrice, this.hotPrice});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        itemTitle: json['item_title'],
        size: json['size'] == null
            ? null
            : List<String>.from(json['size'].map((x) => x)),
        bPrice: json['b_price'],
        coldPrice: json['cold_price'],
        hotPrice: json['hot_price']);
  }
}
