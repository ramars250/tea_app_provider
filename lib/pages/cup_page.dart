import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/provider/order_provider.dart';
import 'package:tea_app/provider/tea_provider.dart';

class CupPage extends StatelessWidget {
  const CupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: Consumer<TeaProvider>(builder: (context, teaList, child) {
        final item = teaList.selected;
        return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, childAspectRatio: 2.5),
            //不可滑動
            // physics: NeverScrollableScrollPhysics(),
            itemCount: item.bPrice != null ? item.size.length : 1,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Provider.of<OrderProvider>(context, listen: false)
                      .addCupSize(item.size[index]);
                  index == 1
                      ? Provider.of<OrderProvider>(context, listen: false)
                          .addCupPrice(item.bPrice)
                      : Provider.of<OrderProvider>(context, listen: false)
                          .addCupPrice(0);
                  Provider.of<OrderProvider>(context, listen: false).addCupId(index);
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: context.read<OrderProvider>().cupId == index ? Colors.orange[300] : Colors.grey[300]),
                    child: Text(item.size[index],
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center)),
              );
            });
      }),
    );
  }
}
