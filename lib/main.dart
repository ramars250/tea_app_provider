import 'package:flutter/material.dart';
import 'package:tea_app/model/tea_data_model.dart';
import 'package:tea_app/provider/customized_provider.dart';
import 'package:tea_app/provider/order_provider.dart';
import 'package:tea_app/provider/tea_provider.dart';
import 'package:tea_app/screen/car_screen.dart';
import 'package:tea_app/screen/tea_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(TeaApp());

class TeaApp extends StatelessWidget {
  const TeaApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TeaDataModel()),
          ChangeNotifierProvider(create: (context) => TeaProvider()),
          ChangeNotifierProvider(create: (context) => CustomizedProvider()),
          ChangeNotifierProvider(create: (context) => OrderProvider()),
        ],
        child: MaterialApp(
          // home: TeaScreen(),
          routes: {
            '/': (context) => TeaScreen(),
            CarScreen().routeName: (context) => CarScreen(),
          },
        ));
  }
}

// class TeaApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: FrontPage(),
//       routes: {
//         '/': (ctx) => FrontScreen(),
//         ShoppingCartScreen().routeName: (ctx) => ShoppingCartScreen(),
//       },
//     );
//   }
// }
