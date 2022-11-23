import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz_app/src/constants/dimens.dart';
import 'package:quiz_app/src/constants/tints.dart';
import 'package:quiz_app/src/features/quiz/domain/models/volume.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../../common_widgets/decoration/blur_view.dart';
import '../screen/quiz/quiz_provider.dart';

class QuizTopBar extends StatefulWidget {
  final QuizType quizType;

  final double? width;
  final double? height;

  final Color selectedColor;
  final Color unSelectedColor;

  final Function? onPop;

  const QuizTopBar(
      {Key? key,
      required this.quizType,
      this.width,
      this.height,
      this.selectedColor = Tints.MAIN_COLOR,
      this.unSelectedColor = Colors.white,
      this.onPop})
      : super(key: key);

  @override
  State<QuizTopBar> createState() => _QuizTopBarState();
}

class _QuizTopBarState extends State<QuizTopBar> with Logger {
  late QuizProvider _quizProvider;

  @override
  Widget build(BuildContext context) {
    _quizProvider = context.provider();

    return SizedBox(
      width: double.infinity,
      height: Dimens.DEFAULT_TOP_BAR_HEIGHT,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                if (widget.onPop != null) {
                  widget.onPop!();
                }
              },
              child: BlurView(
                width: 40,
                height: 40,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10)
                      .copyWith(right: 2),
                  child: SvgPicture.asset(
                    'assets/icons/left_arrow.svg',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: StepProgressIndicator(
              totalSteps: _quizProvider.questions.length,
              currentStep: _quizProvider.currentQuestion,
              size: 8,
              padding: 0,
              selectedColor: widget.selectedColor,
              unselectedColor: widget.unSelectedColor,
              roundedEdges: const Radius.circular(Dimens.ROUNDED_L),
            ),
          ),
        ),
      ]),
    );
  }
}
