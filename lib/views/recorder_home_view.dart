import 'package:flutter/material.dart';

class RecorderHomeView extends StatelessWidget {
  final String _title;

  const RecorderHomeView({Key key, @required String title})
      : assert(title != null),
        _title = title,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
    );
  }
}
