import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/common_widgets/background/dynamic_wave.dart';
import 'package:quiz_app/common_widgets/decoration/blur_view.dart';
import 'package:quiz_app/core/widgets/base_screen.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/constants/dimens.dart';
import 'package:quiz_app/src/constants/tints.dart';
import 'package:quiz_app/src/features/quiz/domain/models/volume.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/volume/volume_provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/volume/volume_side_effect.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

class VolumeScreen extends StatefulWidget {
  const VolumeScreen({Key? key}) : super(key: key);

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  late VolumeProvider _volumeProvider;

  // support function ----------------------------------------------------------
  void _navigateToTopicScreen() {
    context.pop();
  }

  void _navigateToQuizScreen() {
    context.pushNamed(Routes.QUIZ_SCREEN);
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _volumeProvider = context.provider();

    _volumeProvider.collectSideEffect((effect) {
      if (effect is NavigateToTopicScreen) {
        return _navigateToTopicScreen();
      }
      if (effect is NavigateToQuizScreen) {
        return _navigateToQuizScreen();
      }
    });

    return BaseScreen(
      color: Tints.DARK_GRAY,
      // background: Lottie.asset('assets/raws/white_clouds.json'),
      child: Stack(children: [
        const Align(
          alignment: Alignment.topCenter,
          child: DynamicWave(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Tints.MAIN_COLOR_VARIANT, Tints.MAIN_COLOR]),
            width: double.infinity,
            height: 300,
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _topBar(),
              const SizedBox(height: 10),
              Expanded(
                child: _body(),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget _topBar() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: _volumeProvider.popToTopicScreen,
                child: BlurView(
                  width: 40,
                  height: 40,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10)
                        .copyWith(right: 2),
                    child: SvgPicture.asset(
                      'assets/icons/left_arrow.svg',
                      semanticsLabel: 'left arrow icon',
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Choose Quiz",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15)
          .copyWith(top: 10, bottom: 20),
      child: BlurView(
        // opacity: 0.6,
        borderRadius: BorderRadius.circular(15),
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: _volumeProvider.volumes.length,
          itemBuilder: (context, i) {
            var volume = _volumeProvider.volumes[i];
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: _item(volume),
            );
          },
        ),
      ),
    );
  }

  Widget _item(Volume volume) {
    return GestureDetector(
      onTap: () {
        _volumeProvider.navigateToQuizScreen(context, volume);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.PADDING_M),
        width: double.infinity,
        height: 100.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimens.PADDING_M),
                  Text(
                    volume.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Dimens.PADDING_M),
                  () {
                    switch (volume.quizType) {
                      case QuizType.SINGLE_QUESTION_LIMIT_TIME:
                        return const Text("Type: limited time");
                      case QuizType.MULTI_QUESTION_LIMIT_TIME:
                        return const Text("Type: limited time");
                      case QuizType.SINGLE_QUESTION_NO_LIMIT_TIME:
                        return const Text("Type: unlimited time");
                      case QuizType.MULTI_QUESTION_NO_LIMIT_TIME:
                        return const Text("Type: unlimited time");
                      default:
                        return const SizedBox();
                    }
                  }(),
                  const SizedBox(height: Dimens.PADDING_M),
                  Text(
                    'Highest score = ${_volumeProvider.quizMap[volume.id]?.validNumber ?? 0}',
                  )
                ],
              ),
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset('assets/icons/right_arrow.svg'),
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}
