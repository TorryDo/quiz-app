import 'package:flutter/material.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic_provider.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import 'volume_screen.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  late TopicProvider _topicProvider;

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _topicProvider = context.provider();

    return Container(
      color: Colors.blueAccent,
      child: _grid(),
    );
  }

  Widget _grid() {
    return ListView(
      children: _topicProvider.topics.mapTo((item) {
        return GestureDetector(
            child: Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.redAccent,
                child: Center(child: Text(item.title))),
            onTap: () {
              _topicProvider.navigateToVolumeScreen(context, item);
            });
      }),
    );
  }
}
