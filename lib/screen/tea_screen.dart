import 'package:flutter/material.dart';
import 'package:tea_app/pages/tea_page.dart';

class TeaScreen extends StatelessWidget {
  const TeaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('testProvider-Future'),
        ),
        body: TeaPage(),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          color: Colors.lightBlue,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'detail-page');
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
}
