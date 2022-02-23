import 'package:flutter/material.dart';

class ScaleAnimationWidget extends StatefulWidget {
  final Widget child;
  final Widget child_2;
  final int duration;

  const ScaleAnimationWidget(
      {Key? key,
      required this.child,
      required this.child_2,
      this.duration = 1000})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget>
    with TickerProviderStateMixin<ScaleAnimationWidget> {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> animation_2;

  ///처음 widget을 build시키면 Tween의 end의 값으로 애니메이션이 종료된 상태로 그려진다
  ///그래서 Tween의 end값을 1.0으로 설정
  ///end가 1.0이기 때문에 onTap을 호출했을 때는 reverse 먼저 호출하고, 그다음에 forward호출
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration),
        value: 1.0);
    animation = Tween(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
    );
    animation_2 = Tween(begin: 0.3, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
        reverseCurve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      controller.repeat(reverse: true);
    } catch (e) {
      print(e);
    }
    return Stack(
      children: [
        ScaleTransition(scale: animation, child: widget.child),
        ScaleTransition(scale: animation_2, child: widget.child_2),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
