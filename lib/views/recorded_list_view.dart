import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RecordListView extends StatefulWidget {
  final List<String> records;
  const RecordListView({
    Key key,
    this.records,
  }) : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  int _totalDuration;
  int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.records.length,
      shrinkWrap: true,
      reverse: true,
      addAutomaticKeepAlives: true,
      itemBuilder: (BuildContext context, int i) {
        String filePath = widget.records.elementAt(i);

        String fromEpoch = filePath.substring(
            filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

        DateTime recordedDate =
            DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));
        int year = recordedDate.year;
        int month = recordedDate.month;
        int day = recordedDate.day;
        return ExpansionTile(
          key: Key(i.toString()),
          initiallyExpanded: false,
          title: Text('New recoding ${widget.records.length - i}'),
          subtitle: Text('$year-$month-$day'),
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    value: _completedPercentage,
                  ),
                  IconButton(
                    icon:
                        _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    onPressed: () =>
                        _onPlay(filePath: widget.records.elementAt(i)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onPlay({@required String filePath}) async {
    print('we gonna play this file');

    AudioPlayer audioPlayer = AudioPlayer();

    if (!_isPlaying) {
      audioPlayer.play(filePath, isLocal: true);
      setState(() {
        _completedPercentage = 0.0;
        _isPlaying = true;
      });

      audioPlayer.onPlayerCompletion.listen((_) {
        setState(() {
          _isPlaying = false;
        });
      });
      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
          print(_completedPercentage);
        });
      });
    }
  }
}
