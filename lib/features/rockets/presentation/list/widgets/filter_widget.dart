import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final Function(bool) _onFilterClicked;

  FilterWidget(this._onFilterClicked);

  @override
  State<StatefulWidget> createState() {
    return _FilterWidgetState();
  }
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.filter_list_alt,
        color: _isActive ? Colors.white : Colors.white38,
      ),
      onPressed: () {
        _onClicked();
      },
    );
  }

  void _onClicked() {
    setState(() {
      _isActive = !_isActive;
      widget._onFilterClicked(_isActive);
    });
  }
}
