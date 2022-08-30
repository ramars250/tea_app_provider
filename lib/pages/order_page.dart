import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/pages/cup_page.dart';
import 'package:tea_app/pages/feed_page.dart';
import 'package:tea_app/pages/ice_page.dart';
import 'package:tea_app/pages/sweet_page.dart';
import 'package:tea_app/provider/order_provider.dart';
import 'package:tea_app/provider/tea_provider.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key key}) : super(key: key);
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final teaList = Provider.of<TeaProvider>(context);
    final teaData = teaList.selected;
    final detail = Provider.of<OrderProvider>(context);
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
                      child: Text(teaData.itemTitle,
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
              CupPage(),
              Text('溫度', style: TextStyle(fontSize: 16)),
              IcePage(),
              Text('糖度', style: TextStyle(fontSize: 16)),
              SweetPage(),
              FeedPage(),
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
                          Container(child: Text('總金額${detail.totalPrice}元')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  detail.removeQty();
                                },
                                icon: Icon(Icons.remove, color: Colors.red),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(detail.qty.toString()),
                              ),
                              IconButton(
                                onPressed: () {
                                  detail.addQty();
                                },
                                icon: Icon(Icons.add, color: Colors.green),
                              ),
                            ],
                          ),
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
                          Provider.of<OrderProvider>(context, listen: false)
                              .addName(textController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
