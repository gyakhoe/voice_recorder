import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class RecorderView extends StatefulWidget {
  final Function onSaved;

  const RecorderView({Key key, @required this.onSaved}) : super(key: key);
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

  // Recorder properties
  FlutterAudioRecorder audioRecorder;

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
          onPressed: _onRecordButtonPressed,
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

  Future<void> _onRecordButtonPressed() async {
    switch (recordingState) {
      case RecordingState.Set:
        await _initRecorder();
        await _startRecording();

        setState(() {
          recordingState = RecordingState.Recording;
          recordIcon = Icons.stop;
          recordText = 'Recording';
        });
        break;

      case RecordingState.Recording:
        await _stopRecording();

        setState(() {
          recordingState = RecordingState.Stopped;
          recordIcon = Icons.fiber_manual_record;
          recordText = 'Record new one';
        });
        break;

      case RecordingState.Stopped:
        await _initRecorder();
        await _startRecording();

        setState(() {
          recordingState = RecordingState.Recording;
          recordIcon = Icons.stop;
          recordText = 'Recording';
        });
        break;

      default:
        recordingState = RecordingState.Set;
        recordIcon = Icons.mic_none;
        recordText = 'Click to Start';
        setState(() {});
        break;
    }
    setState(() {});
  }

  _initRecorder() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();

    print(appDirectory);
    String filePath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
    print('file path is : $filePath');

    print(
        'Recorder permission is : ${await FlutterAudioRecorder.hasPermissions}');
    audioRecorder =
        FlutterAudioRecorder(filePath, audioFormat: AudioFormat.AAC);
    await audioRecorder.initialized;
  }

  _startRecording() async {
    await audioRecorder.start();
    Recording recording = await audioRecorder.current(channel: 0);
    print('Recording state is : ${recording.status}');
  }

  _stopRecording() async {
    await audioRecorder.stop();

    widget.onSaved();
  }
}
