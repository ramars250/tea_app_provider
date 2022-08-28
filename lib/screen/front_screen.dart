import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tea_app/model/customer_model.dart';
import 'package:tea_app/model/detail_model.dart';
import 'package:tea_app/model/tea_model.dart';
import 'package:tea_app/screen//shopping_cart_screen.dart';

class FrontScreen extends StatefulWidget {
  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  //創一個名字為data屬於TeaData的列表
  List<TeaData> data = [];
  List<CustomerData> cData = [];
  List<DetailItems> detailList = [];

  //建立Feed索引列表
  List<int> selectFeed = [];

  //建立選中Feed名稱
  String _selectFeedText;

  //文本控制器
  final textController = TextEditingController();

  //選中項目
  int tap_index;

  //需要回傳的變數
  String cName;
  String cTitle;
  String cSize;
  String cIce;
  String cSweet;
  String cFeed;
  int cQty;

  @override
  void initState() {
    super.initState();
    loadingTeaJsonData();
    loadingCustomeJsonrData();
    // getDetailList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TEA&TOP'),
          centerTitle: true,
        ),
        body: ListView(
          children: data.map((TeaData teaDataList) {
            return Card(
              color: Colors.lightBlue[100],
              child: ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.end,
                maintainState: true,
                title: Text(
                  '${teaDataList.kindTitle}',
                ),
                children: [
                  buildTeaTitle(teaDataList, context),
                ],
              ),
            );
          }).toList(),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          color: Colors.lightBlue,
          child: InkWell(
            onTap: () {
              //將DeTailItem的資料以列表方式推送到DetailPage頁面
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(
                    detailList: DetailList(detailList),
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  Text('去結帳'),
                ],
              ),
            ),
          ),
        ));
  }

  //teaTitle列表
  Widget buildTeaTitle(TeaData teaDataList, BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: teaDataList.items.length,
        itemBuilder: (_, index) {
          final itemList = teaDataList.items[index];
          return Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (itemList) => DetailPage()));
                showDialog(
                    context: context,
                    builder: (_) {
                      return buildDetail(itemList, context);
                    });
              },
              leading: Container(
                width: 250,
                child: Text(itemList.itemTitle),
              ),
              title: Text('${itemList.coldPrice}'),
              trailing: itemList.hotPrice != null
                  ? Text('${itemList.hotPrice}')
                  : null,
              tileColor: Colors.black,
            ),
          );
        });
  }

  //客製化內容的程式
  Widget buildDetail(Item itemList, BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Expanded(
                      child: Text(itemList.itemTitle,
                          style: TextStyle(fontSize: 25)),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: Colors.redAccent[100]),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      )),
                ],
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
              Container(
                  alignment: Alignment.centerLeft, child: Text('訂購人姓名(非必填)')),
              Container(
                child: TextField(
                  controller: textController,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: false,
                  decoration: InputDecoration(
                      //isCollapsed設為true，用來關閉預設輸入框
                      isCollapsed: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      hintText: '非商品備註，僅提供填寫訂購人資訊'),
                ),
              ),
              SizedBox(height: 10),
              Text('杯型', style: TextStyle(fontSize: 16)),
              buildCupSize(context, itemList),
              Text('溫度', style: TextStyle(fontSize: 16)),
              buildIce(context, itemList),
              Text('糖度', style: TextStyle(fontSize: 16)),
              buildSewwt(),
              buildFeed(),
              Padding(padding: EdgeInsets.all(2)),
              Divider(height: 1.5, color: Colors.grey),
              Container(
                  padding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(child: Text('總金額${itemList.coldPrice}元')),
                            Container(child: Text('數量條還沒做'))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.lightBlue[300],
                        ),
                        child: TextButton(
                            child: Text(
                              '訂購',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              getDetailList();
                              // print(detailList.length);
                              //將訂購頁的資料返回主頁
                              Navigator.pop(
                                  context,
                                  DetailItems(cName, cTitle, cSize, cIce,
                                      cSweet, cFeed, cQty));
                            }),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //杯型大小的程式
  Widget buildCupSize(BuildContext context, Item itemList) {
    int tap_index;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        alignment: Alignment.centerLeft,
        // height: 60,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, childAspectRatio: 2.5),
            //不可滑動
            // physics: NeverScrollableScrollPhysics(),
            itemCount: itemList.bPrice != null ? itemList.size.length : 1,
            itemBuilder: (_, index) {
              final size = itemList.size;
              final sizeList = size[index];
              bool tapped = index == tap_index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    // print(index);
                    tap_index = index;
                    cName = textController.text;
                    cTitle = itemList.itemTitle;
                    cSize = sizeList;
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: tapped ? Colors.orange[300] : Colors.grey[300]),
                    child: Text(sizeList,
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center)),
              );
            }),
      );
    });
  }

  //選擇溫度程式
  Widget buildIce(BuildContext context, Item itemList) {
    int tap_index;
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          alignment: Alignment.centerLeft,
          // height: 140,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5),
              // physics: NeverScrollableScrollPhysics(),
              itemCount: itemList.hotPrice != null
                  ? cData[0].iceCubes.length
                  : cData[0].iceCubes.length - 2,
              itemBuilder: (_, index) {
                final ice = cData[0];
                final iceList = ice.iceCubes[index];
                bool tapped = index == tap_index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // print("Tapped index: $index");
                      tap_index = index;
                      cIce = iceList;
                    });
                  },
                  child: Container(
                      width: 50,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color:
                              tapped ? Colors.orange[300] : Colors.grey[300]),
                      child: Text(iceList, style: TextStyle(fontSize: 12))),
                );
              }),
        );
      },
    );
  }

  //選擇甜度的程式
  Widget buildSewwt() {
    int tap_index;
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        alignment: Alignment.centerLeft,
        // height: 120,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5),
            // physics: NeverScrollableScrollPhysics(),
            itemCount: cData[1].sewwtness.length,
            itemBuilder: (_, index) {
              final sewwt = cData[1];
              final sewwtList = sewwt.sewwtness[index];
              bool tapped = index == tap_index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    // print("Tapped index: $index");
                    tap_index = index;
                    cSweet = sewwtList;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: tapped ? Colors.orange[300] : Colors.grey[300]),
                  child: Text(sewwtList, style: TextStyle(fontSize: 12)),
                ),
              );
            }),
      );
    });
  }

  //選擇加料的程式
  Widget buildFeed() {
    selectFeed = [];
    // int tap_index;
    return StatefulBuilder(builder: (context, setState) {
      return ExpansionTile(
        title: Text('加料(最多可選2項)', style: TextStyle(fontSize: 16)),
        children: [
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.5),
              physics: NeverScrollableScrollPhysics(),
              itemCount: cData[2].feed.length,
              itemBuilder: (_, index) {
                final feed = cData[2];
                final feedList = feed.feed[index].title;
                final priceList = feed.feed[index].price;
                // bool tapped = index == tap_index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      //selectFeed.contains()用於檢查是否有出現在列表(bool值)，有的話將其移除，沒有的話就加入列表
                      selectFeed.contains(index)
                          ? selectFeed.remove(index)
                          : selectFeed.add(index);
                      selectFeed.length > 2
                          ? selectFeed.clear()
                          : selectFeed.length;
                      // tap_index = index;
                      getSelectedFeed();
                      selectFeed.length != 0
                          ? cFeed = _selectFeedText
                          : cFeed = null;
                      // print(cFeed);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: selectFeed.contains(index)
                            ? Colors.orange[300]
                            : Colors.grey[300]),
                    child: Text('$feedList \n+$priceList元',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center),
                  ),
                );
              }),
        ],
      );
    });
  }

  //取得加料內容的文字
  getSelectedFeed() {
    String selectFeedText = '';
    selectFeed.forEach((element) {
      if (selectFeedText != '') selectFeedText += ',';
      selectFeedText += (cData[2].feed[element].title);
      _selectFeedText = selectFeedText;
      print(_selectFeedText);
      return _selectFeedText;
    });
  }

  //將Dialog返回的資料做成陣列
  getDetailList() async {
    final result = DetailItems(cName, cTitle, cSize, cIce, cSweet, cFeed, cQty);
    detailList.add(result);
    return detailList;
  }

  //解析tea.json資料
  Future<TeaList> loadingTeaJsonData() async {
    // 設字串變數listJson等於本地json內容
    String jsonData = await rootBundle.loadString('assets/json/tea.json');
    //設變數jsonResponse為json解碼後的內容
    final jsonResponse = json.decode(jsonData);
    //設TeaList的類型為list的teaData為TeaList反序列化的內容
    TeaList teaData = TeaList.fromJson(jsonResponse);
    //更新狀態，將teaData.teaData的反序列化內容指定給先前建立的data列表，方便需要使用的時候可用
    setState(() {
      this.data = teaData.teaData;
    });
    return teaData;
  }

  //解析customized.json資料
  Future<CustomerList> loadingCustomeJsonrData() async {
    String jsonData =
        await rootBundle.loadString('assets/json/customized.json');
    final jsonResponse = json.decode(jsonData);
    CustomerList customerData = CustomerList.fromJson(jsonResponse);
    // print(customerData.cData[0].iceCubes);
    setState(() {
      this.cData = customerData.cData;
    });
    return customerData;
  }
}
