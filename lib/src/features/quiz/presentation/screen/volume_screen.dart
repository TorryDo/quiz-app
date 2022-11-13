import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/src/features/quiz/domain/models/volume.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/question_screen.dart';
import 'package:quiz_app/src/features/quiz/presentation/quiz_provider.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

class VolumeScreen extends StatefulWidget {

  final Topic topic;

  const VolumeScreen({Key? key, required this.topic}) : super(key: key);

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  late QuizProvider _topicProvider;



  void _navigateToQuestionScreen(Volume volume){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionScreen(volume: volume))
    );
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _topicProvider = context.provider();
    _topicProvider.getVolumesByTopic(widget.topic);

    return Material(color: Colors.black, child: _body());
  }

  Widget _body() {
    return ListView(
      children: [
        for (var item in _topicProvider.volumes)
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: 60.0,
              color: Colors.blueAccent,
              child: Center(child: Text(item.title)),
            ),
            onTap: () {
              _topicProvider.onVolumeTap(item);
              _navigateToQuestionScreen(item);
            },
          )
      ],
    );
  }
}
