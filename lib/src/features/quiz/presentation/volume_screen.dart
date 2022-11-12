import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/question_screen.dart';
import 'package:quiz_app/src/features/quiz/presentation/quiz_provider.dart';

class VolumeScreen extends StatefulWidget {
  const VolumeScreen({Key? key}) : super(key: key);

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  late QuizProvider _topicProvider;

  void _navigateToQuestionScreen(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuestionScreen()),
    );
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _topicProvider = context.read();

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
              _navigateToQuestionScreen();
            },
          )
      ],
    );
  }
}
