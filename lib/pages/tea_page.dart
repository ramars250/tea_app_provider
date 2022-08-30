import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/pages/order_page.dart';
import 'package:tea_app/provider/customized_provider.dart';
import 'package:tea_app/provider/order_provider.dart';
import 'package:tea_app/provider/tea_provider.dart';

class TeaPage extends StatelessWidget {
  const TeaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerList = Provider.of<CustomizedProvider>(context);
    customerList.getCustomerData();
    final teaList = Provider.of<TeaProvider>(context);
    teaList.getTeaData();
    return teaList.teaData == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: teaList.teaData.teaData.length,
            itemBuilder: (context, index) {
              final teaData = teaList.teaData.teaData[index];
              return Card(
                color: Colors.lightBlue[100],
                child: ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.end,
                  maintainState: true,
                  title: Text(teaList.teaData.teaData[index].kindTitle),
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: teaData.items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white,
                            child: ListTile(
                              onTap: () {
                                teaList.setItemSelected(teaData.items[index]);
                                Provider.of<OrderProvider>(context, listen: false).addTeaTitle(teaData.items[index].itemTitle);
                                Provider.of<OrderProvider>(context, listen: false).addTeaPrice(teaData.items[index].coldPrice);
                                Provider.of<OrderProvider>(context, listen: false).addTotalPrice();
                                // Navigator.push(context, MaterialPageRoute(builder: (itemList) => DetailPage()));
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return OrderPage();
                                  },
                                );
                              },
                              leading: Container(
                                width: 250,
                                child: Text(teaData.items[index].itemTitle),
                              ),
                              title: Text('${teaData.items[index].coldPrice}'),
                              trailing: teaData.items[index].hotPrice != null
                                  ? Text('${teaData.items[index].hotPrice}')
                                  : null,
                              tileColor: Colors.black,
                            ),
                          );
                        })
                  ],
                ),
              );
            },
          );
  }
}
