import 'package:flutter/material.dart';
import 'package:tea_app/model/tea_data_model.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TeaDataModel>().fetchData;
    return Scaffold(
      appBar: AppBar(
        title: Text('testProvider-Future'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Center(
          child: Consumer<TeaDataModel>(
            builder: (context, value, child) {
              return value.map.length == 0
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: value.map['tea_data'].length,
                      itemBuilder: (context, index) {
                        return TeaCard(map: value.map['tea_data'][index]);
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

class TeaCard extends StatelessWidget {
  const TeaCard({Key key, this.map}) : super(key: key);
  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue[100],
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.end,
        maintainState: true,
        title: Text(map['kind_title']),
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: map['items'].length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (itemList) => DetailPage()));
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: Text('test'),
                            );
                          });
                    },
                    leading: Container(
                      width: 250,
                      child: Text(map['items'][index]['item_title']),
                    ),
                    title: Text('${map['items'][index]['cold_price']}'),
                    trailing: map['items'][index]['hot_price'] != null
                        ? Text('${map['items'][index]['hot_price']}')
                        : null,
                    tileColor: Colors.black,
                  ),
                );
              })
        ],
      ),
    );
  }
}
