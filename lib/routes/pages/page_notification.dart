import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flutter/material.dart';
import 'package:flukit/flukit.dart';

class InfoRoute extends StatefulWidget {
  @override
  _InfoRouteState createState() => _InfoRouteState();
}

class _InfoRouteState extends State<InfoRoute> with TickerProviderStateMixin {
  var data = <Notifi>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('通知'),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8), child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return InfiniteListView<Notifi>(
      onRetrieveData: (int page, List<Notifi> items, bool refresh) async {
        //page是从1开始，不是从0开始
        if (data.length == 0 || refresh == true) {
          if (refresh == true) {
            data.clear();
          }
          var json = await Net().getNotiList(refresh);
          var jsonNotifi = json['list'] as List;
          data.addAll(jsonNotifi.map((v) => Notifi.fromJson(v)).toList());
        }

        //把请求到的新数据添加到items中
     //   print("data:" + data.length.toString());
        var sublist;
        if ((page) * 10 > data.length) {
          sublist = data.sublist((page - 1) * 10);
        } else {
          sublist = data.sublist((page - 1) * 10, page * 10);
        }
        items.addAll(sublist);
   //     print(page.toString() + items.length.toString());
        return (items.length > 0) && (sublist.length % 10 == 0);
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        return GestureDetector(
          onTap: () async {
            //  await new Net().getNotiList();
          },
          child: Card(
            margin: EdgeInsets.all(4),
            child: NotiItem(list[index]),
          ),
        );
      },
    );
  }
}
