import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/provider/order_provider.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key key}) : super(key: key);
  final String routeName = 'detail-page';

  @override
  Widget build(BuildContext context) {
    final detail = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('購物車'),
        ),
        body: Container(
          color: Colors.grey,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(detail.name, style: TextStyle(fontSize: 30)),
                  Text(detail.teaTitle, style: TextStyle(fontSize: 36)),
                  Row(
                    children: [
                      Text(detail.cupSize, style: TextStyle(fontSize: 20)),
                      SizedBox(width: 5),
                      Text(detail.ice, style: TextStyle(fontSize: 20)),
                      SizedBox(width: 5),
                      Text(detail.sweet, style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
