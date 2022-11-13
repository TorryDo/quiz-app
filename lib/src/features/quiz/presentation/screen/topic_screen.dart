import 'package:flutter/material.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import '../../../auth/presentation/auth_provider.dart';
import '../quiz_provider.dart';
import 'volume_screen.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  late AuthProvider _authProvider;
  late QuizProvider _quizProvider;

  void _navigateToVolumeRoute(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VolumeScreen(topic: topic)),
    );
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    _authProvider = context.provider<AuthProvider>();
    _quizProvider = context.provider<QuizProvider>();

    return Container(
      color: Colors.blueAccent,
      child: _grid(),
    );
  }

  Widget _grid() {
    return ListView(
      children: [
        for (var topic in _quizProvider.topics)
          GestureDetector(
            child: Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.redAccent,
                child: Center(child: Text(topic.title))),
            onTap: () {
              _quizProvider.onTopicTap(topic);
              _navigateToVolumeRoute(topic);
            },
          )
      ],
    );
  }
}
