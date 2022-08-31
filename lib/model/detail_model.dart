//建立要推送的DetailItem模型
class DetailItems {
  String orderName;
  String itemTitle;
  String cupSize;
  String iceCube;
  String sweet;
  String feed;
  int qty;

  // final String feed;
  DetailItems(this.orderName, this.itemTitle, this.cupSize, this.iceCube,
      this.sweet, this.feed, this.qty);
}

//建立包含DetailItem模型的列表
class DetailList {
  List<DetailItems> detailList;

  DetailList(this.detailList);
}
