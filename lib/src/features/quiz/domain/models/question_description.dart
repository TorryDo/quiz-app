import 'package:flutter/widgets.dart';
import 'package:quiz_app/src/features/quiz/presentation/view/description_text.dart';

abstract class QuestionDescription {
  Widget render();
}

class DescriptionOnly extends QuestionDescription {
  String description = '';

  DescriptionOnly(this.description);

  @override
  Widget render() {
    return DescriptionText(description: description);
  }
}

class DescriptionWithImage extends QuestionDescription {
  String description = '';

  String imageSrc;

  DescriptionWithImage(this.description, {required this.imageSrc});

  @override
  Widget render() {
    return Column(
      children: [
        DescriptionText(description: description),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(imageSrc),
        )
      ],
    );
  }
}
