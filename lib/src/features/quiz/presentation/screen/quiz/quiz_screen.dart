import 'package:flutter/material.dart';
import 'package:quiz_app/core/hook.dart';
import 'package:quiz_app/src/features/quiz/domain/models/question_answer.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../../domain/models/question.dart';
import '../../../domain/models/volume.dart';
import '../../view/quiz_topbar.dart';
import 'quiz_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with Logger, Hook {
  late QuizProvider _quizProvider;

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (_quizProvider.currentQuestion <= 0) return true;
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              "Do you want to exit the quiz?, looks like you're not finished yet",
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => context.pop(false),
                child: const Text('Continue'),
              ),
              TextButton(
                onPressed: () => context.pop(true),
                child: const Text('Quit'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    runOneTime(() {
      _quizProvider = context.provider();
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        color: Colors.blueGrey,
        child: SafeArea(child: _body()),
      ),
    );
  }

  Widget _body() {
    return Column(children: [
      QuizTopBar(width: 150, quizType: _quizProvider.volume.quizType),
      Flexible(flex: 1, child: _questionHorizontalView()),
    ]);
  }

  Widget _questionHorizontalView() {
    bool isSingleQuestion = (_quizProvider.volume.quizType ==
            QuizType.SINGLE_QUESTION_NO_LIMIT_TIME ||
        _quizProvider.volume.quizType == QuizType.SINGLE_QUESTION_LIMIT_TIME);

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
            _quizProvider.currentQuestion = position;
          });
        },
        children: _quizProvider.questions.mapIndexed((question, position) {
          return _item(question, position);
        }));
  }

  Widget _item(Question question, int position) {
    question.questionAnswer.collectSideEffect((event) {
      if (event is AnswerValid) {
        // d('pos = $position - leng = ${_quizProvider.questions.length}');
        if (position >= _quizProvider.questions.length - 1) {
          _quizProvider.navigateToSummaryScreen(context);
          return;
        }
        var nextPage = _quizProvider.currentQuestion + 1;
        _pageController.jumpToPage(nextPage);
      } else if (event is AnswerInValid) {
        _quizProvider.navigateToSummaryScreen(context);
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
  }
}
