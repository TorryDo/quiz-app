import 'package:flutter/widgets.dart';

abstract class QuestionDescription {
  Widget render();
}

class DescriptionOnly extends QuestionDescription {
  String description = '';

  DescriptionOnly(this.description);

  @override
  Widget render() {
    return Text(description);
  }

}

class DescriptionWithImage extends QuestionDescription {
  String description = '';

  Widget image;

  DescriptionWithImage(this.description, {required this.image});

  @override
  Widget render() {
    return Column(
      children: [Text(description), image],
    );
  }
}
