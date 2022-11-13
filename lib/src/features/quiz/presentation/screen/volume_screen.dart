import 'package:flutter/material.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/volume_provider.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
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

    return Material(color: Colors.black, child: _body());
  }

  Widget _body() {
    return ListView(
      children: _volumeProvider.volumes.mapTo((volume) => GestureDetector(
            child: Container(
              width: double.infinity,
              height: 60.0,
              color: Colors.blueAccent,
              child: Center(child: Text(volume.title)),
            ),
            onTap: () {
              _volumeProvider.navigateToQuizScreen(context, volume);
            },
          )),
    );
  }
}
