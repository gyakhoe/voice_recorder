import 'package:flutter/material.dart';

class RecorderView extends StatefulWidget {
  @override
  _RecorderViewState createState() => _RecorderViewState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}

class _RecorderViewState extends State<RecorderView> {
  IconData recordIcon = Icons.mic_none;
  String recordText = 'Click To Start';
  RecordingState recordingState = RecordingState.UnSet;

  @override
  void initState() {
    recordingState = RecordingState.Set;
    super.initState();
  }

  @override
  void dispose() {
    recordingState = RecordingState.UnSet;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RaisedButton(
          onPressed: _changeRecordinState,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            width: 150,
            height: 150,
            child: Icon(
              recordIcon,
              size: 50,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              child: Text(recordText),
              padding: const EdgeInsets.all(8),
            ))
      ],
    );
  }

  void _changeRecordinState() {
    setState(() {
      switch (recordingState) {
        case RecordingState.Set:
          recordingState = RecordingState.Recording;
          recordIcon = Icons.stop;
          recordText = 'Recording';
          break;

        case RecordingState.Recording:
          recordingState = RecordingState.Stopped;
          recordIcon = Icons.fiber_manual_record;
          recordText = 'Record new one';
          break;

        case RecordingState.Stopped:
          recordingState = RecordingState.Recording;
          recordIcon = Icons.stop;
          recordText = 'Recording';
          break;

        default:
          recordingState = RecordingState.Set;
          recordIcon = Icons.mic_none;
          recordText = 'Click to Start';
          break;
      }
    });
  }
}
