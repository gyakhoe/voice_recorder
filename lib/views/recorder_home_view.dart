import 'package:flutter/material.dart';
import 'package:voice_reocrder/views/recorded_list_view.dart';
import 'package:voice_reocrder/views/recorder_view.dart';

class RecorderHomeView extends StatefulWidget {
  final String _title;

  const RecorderHomeView({Key key, @required String title})
      : assert(title != null),
        _title = title,
        super(key: key);

  @override
  _RecorderHomeViewState createState() => _RecorderHomeViewState();
}

class _RecorderHomeViewState extends State<RecorderHomeView> {
  List<String> records = ['record 1', 'record 2'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: RecorderView(),
          ),
          Expanded(
            flex: 2,
            child: RecordListView(
              records: records,
            ),
          ),
        ],
      ),
    );
  }
}
