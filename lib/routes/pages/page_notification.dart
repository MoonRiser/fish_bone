import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flutter/material.dart';
import 'package:flukit/flukit.dart';

class InfoRoute extends StatefulWidget {
  @override
  _InfoRouteState createState() => _InfoRouteState();
}

class _InfoRouteState extends State<InfoRoute> with TickerProviderStateMixin {
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
    var data = <NotiBean>[];
    for (int i = 0; i < 5; i++) {
      data.add(new NotiBean('小明$i', "死去元知万事空，但悲不见九州同.\n王师北定中原日，家祭无忘告乃翁",
          'SS5${i}1', "1989-0${i}/04"));
    }

    return InfiniteListView<NotiBean>(
      onRetrieveData: (int page, List<NotiBean> items, bool refresh) async {
        //把请求到的新数据添加到items中
        items.addAll(data);
        return data.length > 0 && data.length % 5 == 0;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        return Card(
          margin: EdgeInsets.all(4),
          child: NotiItem(list[index]),
        );
      },
    );
  }
}
