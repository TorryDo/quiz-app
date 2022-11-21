import 'package:flutter/material.dart';
import 'package:quiz_app/src/constants/dimens.dart';
import 'package:quiz_app/src/constants/tints.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic/topic_screen_side_effect.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic/topic_provider.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';

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

  void _navigateToVolumeScreen(){
    context.pushNamed(Routes.VOLUME_SCREEN);
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _topicProvider = context.provider();

    _topicProvider.collectSideEffect((effect){
      if(effect is NavigateToVolumeScreen){
        return _navigateToVolumeScreen();
      }
    });

    return Container(
      color: Colors.blueAccent,
      child: SafeArea(
        child: Column(
          children: [
            _topBar(),
            Expanded(
              child: Container(
                color: Colors.white70,
                child: _topics(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return AppBar(
      title: const Text("Choose Topic"),
    );
  }

  Widget _topics() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
      ),
      itemCount: _topicProvider.topics.length,
      itemBuilder: (BuildContext context, int index) {
        return _item(_topicProvider.topics[index]);
      },
    );
  }

  Widget _item(Topic item) {
    return GestureDetector(
      child: Card(
        color: Tints.MAIN_COLOR.withOpacity(0.3),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(item.title, style: const TextStyle(color: Tints.THEME_COLOR),),
                const SizedBox(height: Dimens.PADDING_S),
                Text(item.description, style: const TextStyle(color: Tints.THEME_COLOR))
              ],
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
