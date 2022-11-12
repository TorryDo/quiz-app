import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/volume_screen.dart';

import '../../auth/presentation/auth_provider.dart';
import 'quiz_provider.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  late AuthProvider _authProvider;
  late QuizProvider _topicProvider;


  void _navigateToVolumeRoute(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VolumeScreen()),
    );
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _authProvider = context.read<AuthProvider>();
    _topicProvider = context.read<QuizProvider>();

    return Container(
      color: Colors.blueAccent,
      child: _grid(),
    );
  }

  Widget _grid() {
    var topics = _topicProvider.topics;

    return ListView(
      children: [
        for (var e in topics)
          GestureDetector(
            child: Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.redAccent,
                child: Center(child: Text(e.title))),
            onTap: (){
              _topicProvider.onTopicTap(e);
              _navigateToVolumeRoute();
            },
          )
      ],
    );
  }
}
