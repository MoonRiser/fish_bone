import 'package:fish_bone/common/network_api.dart';
import 'package:fish_bone/common/widgets_my.dart';
import 'package:fish_bone/models/bean.dart';
import 'package:fish_bone/widgets/item_noti.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/flutter_custom_calendar.dart';

class InfoRoute extends StatefulWidget {
  @override
  _InfoRouteState createState() => _InfoRouteState();
}

class _InfoRouteState extends State<InfoRoute> with TickerProviderStateMixin {
  var data = <Notifi>[];
  var tabs = <Widget>[
    Text('日志评论'),
    Text('任务日历'),
    Text("项目日历"),
  ];
  var tabcontroller;
  var _appBarColor;
  var calendar1;
  var calendar2;
  var calendarController1 = new CalendarController(
      nowYear: DateTime.now().year,
      nowMonth: DateTime.now().month,
      selectMode: CalendarConstants.MODE_SINGLE_SELECT,
      selectDateModel: DateModel.fromDateTime(DateTime.now()),
      minYear: 2018,
      minYearMonth: 1,
      maxYear: 2025,
      maxYearMonth: 12,
      showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK);
  var calendarController2 = new CalendarController(
      nowYear: DateTime.now().year,
      nowMonth: DateTime.now().month,
      selectMode: CalendarConstants.MODE_SINGLE_SELECT,
      selectDateModel: DateModel.fromDateTime(DateTime.now()),
      minYear: 2000,
      minYearMonth: 1,
      maxYear: 2025,
      maxYearMonth: 12,
      showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK);

  final ColorTween colorTween =
      new ColorTween(begin: Colors.blue, end: Colors.deepOrange);

  @override
  void initState() {
    super.initState();
    tabcontroller = new TabController(length: 3, vsync: this);
    Animation animation = tabcontroller.animation;
    animation.addListener(() {
      //   print(animation.value);
      setState(() {
        _appBarColor = colorTween.evaluate(animation);
      });
    });
    calendar1 = CalendarViewWidget(
      dayWidgetBuilder: (dateModle) => MyCustomDayWidget(dateModle),
      calendarController: calendarController1,
      margin: EdgeInsets.only(bottom: 0.0),
    );
    calendar2 = CalendarViewWidget(
      dayWidgetBuilder: (dateModle) => MyCustomDayWidget(dateModle),
      calendarController: calendarController2,
      margin: EdgeInsets.only(bottom: 0.0),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabcontroller as TabController..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColor,
        automaticallyImplyLeading: false,
        title: Text('通知/日历'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          controller: tabcontroller,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: tabcontroller,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: _buildBody()),
          MyCalerdarView(calendarController1, calendar1),
          MyCalerdarView(calendarController2, calendar2),
        ],
      ),
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

class MyCalerdarView extends StatefulWidget {
  final CalendarController controller;
  final CalendarViewWidget calendar;

  MyCalerdarView(this.controller, this.calendar);

  @override
  _MyCalerdarViewState createState() => _MyCalerdarViewState();
}

class _MyCalerdarViewState extends State<MyCalerdarView> {
  var _selectDateModel = DateModel.fromDateTime(DateTime.now());
  var controller;
  var currentMon;
  var currentYear;

  @override
  void initState() {
    super.initState();
    currentYear = DateTime.now().year;
    currentMon = DateTime.now().month;
    controller = widget.controller;
    controller.addOnCalendarSelectListener((dateModel) {
      _selectDateModel = dateModel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var calendar = widget.calendar;

    return Column(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Padding(
            padding: EdgeInsets.fromLTRB(4, 24, 0, 16),
            child: Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    controller.addMonthChangeListener((year, month) {
                      currentYear = year;
                      currentMon = month;
                      (context as Element).markNeedsBuild();
                    });
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "$currentMon月",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 2.0,
                        ),
                        Spacer(),
                        Text(
                          currentYear.toString(),
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textScaleFactor: 1.4,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    );
                  },
                ),
                Divider(),
                calendar,
              ],
            ),
          ),
        ),
        Container(
          child: Center(
            child: Text(
                "当前选中的是${_selectDateModel.month}月/${_selectDateModel.day}日 "),
          ),
        ),
      ],
    );
  }
}
