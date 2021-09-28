import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final Widget parent;
  final Widget child;

  const ExpandableWidget({
    required this.parent,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> with SingleTickerProviderStateMixin {
  bool isChildHidden = true;

  late AnimationController _animationController;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    _heightFactor = _animationController.drive(Tween<double>(begin: 0.0, end: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (BuildContext context, Widget? child) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (isChildHidden) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                  isChildHidden = !isChildHidden;
                });
              },
              child: widget.parent,
            ),
            ClipRect(
              child: Align(
                heightFactor: _heightFactor.value,
                child: widget.child,
              ),
            ),
          ],
        );
      },
    );
  }
}
