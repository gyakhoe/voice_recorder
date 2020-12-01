import 'package:flutter/material.dart';

class RecordListView extends StatelessWidget {
  final List<String> records;

  const RecordListView({Key key, @required this.records}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: records.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(records.elementAt(index)),
        );
      },
    );
  }
}
