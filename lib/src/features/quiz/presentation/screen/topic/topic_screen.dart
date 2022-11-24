import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/common_widgets/background/dynamic_wave.dart';
import 'package:quiz_app/core/widgets/base_screen.dart';
import 'package:quiz_app/src/constants/dimens.dart';
import 'package:quiz_app/src/constants/tints.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic/topic_provider.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic/topic_screen_side_effect.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../../../../../common_widgets/decoration/blur_view.dart';
import '../../../../../../routes.dart';
import '../../../domain/models/topic.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> with Logger {
  late TopicProvider _topicProvider;

  // support function ----------------------------------------------------------

  void _navigateToVolumeScreen() {
    context.pushNamed(Routes.VOLUME_SCREEN);
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _topicProvider = context.provider();

    _topicProvider.collectSideEffect((effect) {
      if (effect is NavigateToVolumeScreen) {
        return _navigateToVolumeScreen();
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
                child: _topics(),
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
          const Align(
              alignment: Alignment.center,
              child: Text(
                "Choose topic",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  Widget _topics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15)
          .copyWith(top: 10, bottom: 20),
      child: BlurView(
        // opacity: 0.6,
        borderRadius: BorderRadius.circular(15),
        width: double.infinity,
        height: double.infinity,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          itemCount: _topicProvider.topics.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _item(_topicProvider.topics[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _item(Topic item) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.ROUNDED_L),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.ROUNDED_M),
                color: Tints.GRAY,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Dimens.PADDING_S),
                  Text(item.description,
                      style: const TextStyle())
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        _topicProvider.navigateToVolumeScreen(context, item);
      },
    );
  }
}
