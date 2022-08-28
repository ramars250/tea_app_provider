import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/provider/customized_provider.dart';
import 'package:tea_app/provider/order_provider.dart';
import 'package:tea_app/provider/tea_provider.dart';

class IcePage extends StatelessWidget {
  const IcePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerList = Provider.of<CustomizedProvider>(context);

    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Consumer<TeaProvider>(builder: (context, teaList, child) {
        final item = teaList.selected;
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5),
            // physics: NeverScrollableScrollPhysics(),
            itemCount: item.hotPrice != null
                ? customerList.customerList.cData[0].iceCubes.length
                : customerList.customerList.cData[0].iceCubes.length - 2,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<OrderProvider>(context, listen: false).addIce(customerList.customerList.cData[0].iceCubes[index]);
                },
                child: Container(
                    width: 50,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[300]),
                    child: Text(
                        customerList.customerList.cData[0].iceCubes[index],
                        style: TextStyle(fontSize: 12))),
              );
            });
      }),
    );
  }
}
