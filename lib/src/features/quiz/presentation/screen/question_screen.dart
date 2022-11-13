import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/core/side_effect.dart';
import 'package:quiz_app/src/features/quiz/presentation/quiz_provider.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../domain/models/volume.dart';

class QuestionScreen extends StatefulWidget {
  final Volume volume;

  const QuestionScreen({Key? key, required this.volume}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with Logger, SideEffect {
  late QuizProvider _topicProvider;

  final PageController pageController = PageController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    runOneTime((){
      _topicProvider = context.provider();
      _topicProvider.getQuestionsByVolume(widget.volume);
    });

    return Material(
      color: Colors.blueGrey,
      child: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    return Column(children: [
      Container(
          color: Colors.redAccent,
          width: double.infinity,
          height: 60,
          child: Center(child: Text('${_topicProvider.questionPosition+1}/${_topicProvider.questions.length}'))),
      Flexible(flex: 1, child: _questionHorizontalView()),

    ]);
  }

  Widget _questionHorizontalView() {
    return PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (position) {
          setState(() {
            _topicProvider.questionPosition = position;
          });
        },
        children: [
          for (var question in _topicProvider.questions)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  question.questionDescription.render(),
                  question.questionAnswer.renderInput(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        var isValid = question.questionAnswer.isValid();
                        d(isValid.toString());
                      },
                      child: const Text('check'),
                    ),
                  )
                ],
              ),
            )
        ]);
  }
}
