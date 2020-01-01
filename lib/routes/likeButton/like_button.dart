import 'package:fish_bone/routes/likeButton/painter_circle.dart';
import 'package:fish_bone/routes/likeButton/painter_dots.dart';
import 'package:flutter/material.dart';

typedef LikeCallback = void Function(bool isLike);

class LikeButton extends StatefulWidget {
  final double width;
  final Color color;
  final Duration duration;
  final Icon likeIcon;
  final LikeCallback onIconClicked;

  LikeButton(
      {Key key,
      this.color = Colors.pink,
      this.duration = const Duration(milliseconds: 3000),
      this.likeIcon = const Icon(Icons.favorite),
      this.onIconClicked,
      @required this.width})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> circle;
  Animation<double> dots;
  Animation<double> scale;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    initTween();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CustomPaint(
          size: Size(widget.width * 1.4, widget.width * 1.4),
          painter: DotsPainter(widget.color, dots.value),
        ),
        CustomPaint(
          size: Size(widget.width, widget.width),
          painter: CirclePainter(circle.value, widget.color),
        ),
        Container(
          child: Transform.scale(
            scale: isLiked ? scale.value : 1.0,
            child: GestureDetector(
              child: Icon(
                widget.likeIcon.icon,
                color: isLiked ? widget.color : Colors.grey,
              ),
              onTap: () {
                _onTap();
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initTween() {
    circle = Tween<double>(begin: 0.2, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: new Interval(
        0.0,
        0.6,
        curve: Curves.ease,
      ),
    ));
    dots = Tween<double>(begin: 0.6, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: new Interval(
        0.35,
        1.0,
        curve: Curves.decelerate,
      ),
    ));
    scale = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: new Interval(
        0.35,
        1.0,
        curve: Curves.bounceOut,
      ),
    ));
  }

  void _onTap() {
    if (_controller.isAnimating) return;
    isLiked = !isLiked;
    if (isLiked) {
      _controller.reset();
      _controller.forward();
    } else {
      setState(() {});
    }
    if (widget.onIconClicked != null) widget.onIconClicked(isLiked);
  }
}
