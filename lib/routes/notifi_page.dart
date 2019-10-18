import 'package:flutter/material.dart';
import 'package:flukit/flukit.dart';

class InfoRoute extends StatefulWidget {
  @override
  _InfoRouteState createState() => _InfoRouteState();
}

class _InfoRouteState extends State<InfoRoute> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通知'),
        bottom: TabBar(
          isScrollable: true,
          controller: TabController(initialIndex: 0,length: 2,vsync: this),
          tabs: <Widget>[
            Text("test1"),
            Text('test2')
          ],
        ),
      ),
      body:Text('yes') ,
    );
  }

/*
  Widget _buildBody(){
    return InfiniteListView<Repo>(
      onRetrieveData: (int page, List<Repo> items, bool refresh) async {
        var data = await Git(context).getRepos(
          refresh: refresh,
          queryParameters: {
            'page': page,
            'page_size': 20,
          },
        );
        //把请求到的新数据添加到items中
        items.addAll(data);
        return data.length > 0 && data.length % 20 == 0;
      },
      itemBuilder: (List list, int index, BuildContext ctx) {
        // 项目信息列表项
        return RepoItem(list[index]);
      },
    );
  }
 */




}
