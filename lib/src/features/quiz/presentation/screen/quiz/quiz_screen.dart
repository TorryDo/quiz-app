import 'package:flutter/material.dart';
import 'package:quiz_app/common_widgets/time/countdown_view.dart';
import 'package:quiz_app/core/hook.dart';
import 'package:quiz_app/core/widgets/base_screen.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/quiz/domain/models/question_answer.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/quiz/quiz_screen_side_effect.dart';
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

    _quizProvider.collectSideEffect((effect) {
      if (effect is NavigateToSummaryResultScreen) {
        return context.popAndPushNamed(Routes.SUMMARY_SCREEN);
      }
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseScreen(
        backgroundAsset: 'assets/images/bk3.png',
        child: SafeArea(child: _body()),
      ),
    );
  }

  void _onPop() {
    if (_quizProvider.currentQuestion <= 0) {
      return context.pop();
    }
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          "Do you want to exit the quiz?, looks like you're not finished yet",
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              dialogContext.pop(true);
              context.pop();
            },
            child: const Text('Quit'),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Column(children: [
      const SizedBox(height: 10),
      _topBar(),
      const SizedBox(height: 15),
      Flexible(flex: 1, child: _questionHorizontalView()),
    ]);
  }

  get quizType => _quizProvider.volume.quizType;

  Widget _topBar() {
    if (quizType == QuizType.MULTI_QUESTION_LIMIT_TIME ||
        quizType == QuizType.SINGLE_QUESTION_LIMIT_TIME) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QuizTopBar(
            width: 150,
            quizType: _quizProvider.volume.quizType,
            onPop: () => _onPop(),
          ),
          CountDownView(
            countdown:
                Duration(milliseconds: _quizProvider.volume.countdownInMillis),
            onFinished: () {
              _quizProvider.forceStop(context);
            },
          ),
          const SizedBox(height: 10)
        ],
      );
    }

    return QuizTopBar(
        width: 150,
        quizType: _quizProvider.volume.quizType,
        onPop: () => _onPop());
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
