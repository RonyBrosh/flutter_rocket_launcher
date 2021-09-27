import 'package:flutter/widgets.dart';

class OpacityWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  final bool isReversed;
  final bool isStartVisible;

  const OpacityWidget({
    Key? key,
    required this.scrollController,
    required this.child,
    this.isReversed = false,
    this.isStartVisible = true,
  }) : super(key: key);

  @override
  _OpacityWidgetState createState() => _OpacityWidgetState();
}

class _OpacityWidgetState extends State<OpacityWidget> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    _opacity = widget.isStartVisible ? 1 : 0;
    widget.scrollController.addListener(_calculateOpacity);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_calculateOpacity);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: _opacity, child: widget.child);
  }

  void _calculateOpacity() {
    setState(() {
      final double offset = widget.scrollController.offset / widget.scrollController.position.maxScrollExtent;
      if (widget.isReversed) {
        _opacity = (1 - offset) * 1;
      } else {
        _opacity = offset * 1;
      }
    });
  }
}
