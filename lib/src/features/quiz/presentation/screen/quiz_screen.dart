import 'package:flutter/material.dart';
import 'package:quiz_app/core/hook.dart';
import 'package:quiz_app/src/features/quiz/domain/models/question_answer.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/quiz_provider.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../domain/models/volume.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with Logger, Hook {
  late QuizProvider _quizProvider;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    runOneTime(() {
      _quizProvider = context.provider();
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
          child: Center(
              child: Text(
                  '${_quizProvider.questionPosition + 1}/${_quizProvider.questions.length}'))),
      Flexible(flex: 1, child: _questionHorizontalView()),
    ]);
  }

  Widget _questionHorizontalView() {
    bool isSingleQuestion = (
        _quizProvider.volume.quizType == QuizType.SINGLE_QUESTION_NO_LIMIT_TIME ||
        _quizProvider.volume.quizType == QuizType.SINGLE_QUESTION_LIMIT_TIME
    );

    return PageView(
        physics: () {
          if (isSingleQuestion) {
            return const NeverScrollableScrollPhysics();
          }
          return null;
        }(),
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (position) {
          setState(() {
            _quizProvider.questionPosition = position;
          });
        },
        children: _quizProvider.questions.mapIndexed((question, position) {
          question.questionAnswer.collectSideEffect((event) {
            if (event is AnswerValid) {
              var nextPage = _quizProvider.questionPosition + 1;
              _pageController.jumpToPage(nextPage);
            } else if (event is AnswerInValid) {
              d('answer invalid');
            }
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(child: question.questionDescription.render()),
                question.questionAnswer.renderInput(),
              ],
            ),
          );
        }));
  }
}
