import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterItemWidget extends StatefulWidget {
  FilterItemWidget({Key key}) : super(key: key);

  @override
  _FilterItemWidgetState createState() => _FilterItemWidgetState();
}

class _FilterItemWidgetState extends State<FilterItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.redAccent, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text("MOVIES"),
        ),
      ),
    );
  }
}
