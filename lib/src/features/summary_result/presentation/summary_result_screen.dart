import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/core/widgets/base_screen.dart';
import 'package:quiz_app/src/constants/dimens.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_provider.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_result_side_effect.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

class SummaryResultScreen extends StatelessWidget {
  const SummaryResultScreen({Key? key}) : super(key: key);

  void _navigateBack(BuildContext context) {
    context.pop();
  }

  void _replay() {
    log("<> fake replay");
  }

  @override
  Widget build(BuildContext context) {
    SummaryProvider summaryProvider = context.provider();

    summaryProvider.collectSideEffect((effect) {
      if (effect is NavigateBack) {
        return _navigateBack(context);
      }
      if (effect is Replay) {
        return _replay();
      }
    });

    return BaseScreen(
      // backgroundAsset: 'assets/images/bk5.png',
      background: Image.asset(
        'assets/images/bk5.png',
        fit: BoxFit.cover,
      ),
      child: SafeArea(
        child: Column(
          children: [
            // _topBar(summaryProvider),
            Expanded(child: _middle(summaryProvider)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.PADDING_M),
              child: _bottomButtons(summaryProvider),
            )
          ],
        ),
      ),
    );
  }

  Widget _topBar(SummaryProvider summaryProvider) {
    return AppBar(title: const Text('hello this is a title'));
  }

  Widget _bottomButtons(SummaryProvider summaryProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => summaryProvider.navigateToVolumeScreen(),
          child: const Text('Home Screen'),
        ),
        ElevatedButton(
          onPressed: () => summaryProvider.replay(),
          child: const Text('Play Again'),
        ),
      ],
    );
  }

  Widget _middle(SummaryProvider summaryProvider) {
    final pair = summaryProvider.calcResult();

    Widget summaryType() {
      switch (pair.key) {
        case SummaryType.SOLVED_ALL:
          return _solve_all();
        default:
          return _notMaxScore(pair.value, summaryProvider.questions.length);
        // case SummaryType.SOLVED_80_100:
        //   break;
        // case SummaryType.SOLVED_65_80:
        //   break;
        // case SummaryType.SOLVED_50_65:
        //   break;
        // case SummaryType.SOLVED_25_50:
        //   break;
        // case SummaryType.SOLVED_0_25:
        //   break;
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          summaryType(),
        ]);
  }

  Widget _solve_all() {
    return Column(
      children: [
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'You won this quiz!',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              speed: const Duration(milliseconds: 120),
            ),
          ],
          totalRepeatCount: 3,
          pause: const Duration(seconds: 2),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        )
      ],
    );
  }

  Widget _notMaxScore(int score, int totalQuestion) {
    return Column(
      children: [
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Your score is: $score/$totalQuestion',
              textStyle: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              speed: const Duration(milliseconds: 120),
            ),
          ],
          totalRepeatCount: 3,
          pause: const Duration(seconds: 2),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        )
      ],
    );
  }
}
