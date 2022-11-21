import 'package:flutter/material.dart';
import 'package:quiz_app/src/constants/dimens.dart';
import 'package:quiz_app/src/constants/tints.dart';
import 'package:quiz_app/src/features/quiz/domain/models/volume.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/volume/volume_provider.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

class VolumeScreen extends StatefulWidget {
  const VolumeScreen({Key? key}) : super(key: key);

  @override
  State<VolumeScreen> createState() => _VolumeScreenState();
}

class _VolumeScreenState extends State<VolumeScreen> {
  late VolumeProvider _volumeProvider;

  // UI ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    _volumeProvider = context.provider();

    return Material(
        color: Tints.THEME_COLOR,
        child: Column(
          children: [
            _appBar(),
            Expanded(child: _body()),
          ],
        ));
  }

  Widget _appBar() {
    return AppBar(
      title: const Text('Choose Volume'),
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: _volumeProvider.volumes.length,
      itemBuilder: (context, i) {
        var volume = _volumeProvider.volumes[i];
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
          child: _item(volume),
        );
      },
    );
  }

  Widget _item(Volume volume) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.PADDING_M),
        width: double.infinity,
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.indigoAccent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.PADDING_M),
            Text(
              volume.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Dimens.PADDING_M),
            Text(volume.quizType.name),
            const SizedBox(height: Dimens.PADDING_M),
            Text(
              'Highest score = ${_volumeProvider.quizMap[volume.id]?.validNumber ?? 0}',
            )
          ],
        ),
      ),
      onTap: () {
        _volumeProvider.navigateToQuizScreen(context, volume);
      },
    );
  }
}
