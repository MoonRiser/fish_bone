import 'dart:math';

import 'package:flutter/material.dart';

class CardScrollWidget extends StatefulWidget {
  final CardOnClickCallback callback;
  final List<String> images = [];
  final List<String> titles = [];

  CardScrollWidget(List<String> images, {List<String> titles, this.callback}) {
    this.titles.addAll(titles.reversed);
    this.images.addAll(images.reversed);
  }

  @override
  _CardScrollWidgetState createState() => _CardScrollWidgetState();
}

class _CardScrollWidgetState extends State<CardScrollWidget> {
  final double padding = 20.0;
  final double verticalInset = 20.0;
  double currentPage;
  PageController controller = new PageController();

  @override
  void initState() {
    super.initState();
    currentPage = widget.images.length - 1.0;
    controller = PageController(initialPage: widget.images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
        //print("当前的page是double：$currentPage");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 12.0 / 16.0;
    var widgetAspectRatio = cardAspectRatio * 1.2;

    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < widget.images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () {
                widget.callback(i);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.asset(widget.images[i], fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColorDark,
                                    borderRadius: BorderRadius.circular(24.0)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                margin: EdgeInsets.all(24),
                                child: Text(
                                    widget.titles.length > 0
                                        ? widget.titles[i]
                                        : " ",
                                    style: TextStyle(
                                      color: Colors.white,
//                                    color: Colors.white,
                                      fontSize: 24.0,
                                    )),
                              ),
//                            SizedBox(
//                              height: 10.0,
//                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 12.0, bottom: 12.0),
//                              child: Container(
//                                padding: EdgeInsets.symmetric(
//                                    horizontal: 22.0, vertical: 6.0),
//                                decoration: BoxDecoration(
//                                    color: Colors.blueAccent,
//                                    borderRadius: BorderRadius.circular(20.0)),
//                                child: Text("Read Later",
//                                    style: TextStyle(color: Colors.white)),
//                              ),
//                            )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

          cardList.add(cardItem);
        }

        var swiper = Positioned.fill(
          child: PageView.builder(
            itemCount: widget.images.length,
            controller: controller,
            reverse: true,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        );

        cardList.add(swiper);
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}

typedef void CardOnClickCallback(int index);
//typedef void MyCallback(int result);
