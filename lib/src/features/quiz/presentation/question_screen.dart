import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/quiz_provider.dart';
import 'package:quiz_app/utils/logger.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with Logger {
  late QuizProvider _topicProvider;

  @override
  Widget build(BuildContext context) {
    _topicProvider = context.read();

    return Material(
      color: Colors.blueGrey,
      child: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Column(
        children:[
          _topicProvider.questions[0].questionDescription.render(),
          _topicProvider.questions[0].questionAnswer.renderInput(),
          Center(child: ElevatedButton(onPressed: () {
            var isValid = _topicProvider.questions[0].questionAnswer.isValid();
            d(isValid.toString());
            },
          child: const Text('check'),),)
    ]);
  }
}
