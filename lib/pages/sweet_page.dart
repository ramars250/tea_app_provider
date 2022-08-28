import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/provider/customized_provider.dart';
import 'package:tea_app/provider/order_provider.dart';

class SweetPage extends StatelessWidget {
  const SweetPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final customerList = Provider.of<CustomizedProvider>(context);
    return Container(
      alignment: Alignment.centerLeft,
      child: Consumer<CustomizedProvider>(builder: (context, customerList, child) {
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5),
            // physics: NeverScrollableScrollPhysics(),
            itemCount: customerList.customerList.cData[1].sewwtness.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<OrderProvider>(context, listen: false).addSweet(customerList.customerList.cData[1].sewwtness[index]);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey[300]),
                  child: Text(
                      customerList.customerList.cData[1].sewwtness[index],
                      style: TextStyle(fontSize: 12)),
                ),
              );
            });
      }),
    );
  }
}
