import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/provider/customized_provider.dart';
import 'package:tea_app/provider/order_provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerList = Provider.of<CustomizedProvider>(context);
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
            itemCount: customerList.customerList.cData[2].feed.length,
            itemBuilder: (_, index) {
              // List<int> selectedFeed = [];
              return GestureDetector(
                onTap: () {
                  customerList.setFeedSelected(customerList.customerList.cData[2].feed[index]);
                  Provider.of<OrderProvider>(context, listen: false).addSelectedFeed(index);
                  Provider.of<OrderProvider>(context, listen: false).addFeedPrice(customerList.customerList.cData[2].feed[index].price);
                  Provider.of<OrderProvider>(context, listen: false).addFeedTitle(customerList.customerList.cData[2].feed[index].title);
                  // selectedFeed.contains(index)
                  //     ? selectedFeed.remove(index)
                  //     : selectedFeed.add(index);
                  // selectedFeed.length > 2
                  //     ? selectedFeed.clear()
                  //     : selectedFeed.length;
                  print(context.read<OrderProvider>().feedPrice);
                  Provider.of<OrderProvider>(context, listen: false)
                      .addFeedId(index);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: context.read<OrderProvider>().selectedFeed.contains(index)
                          ? Colors.orange[300]
                          : Colors.grey[300]),
                  child: Text(
                      '${customerList.customerList.cData[2].feed[index].title} \n+${customerList.customerList.cData[2].feed[index].price}元',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center),
                ),
              );
            }),
      ],
    );
  }
}
