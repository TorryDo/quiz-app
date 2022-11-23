import 'package:quiz_app/utils/lang/list_ext.dart';

import '../../../../../utils/logger.dart';
import '../../domain/models/question.dart';
import '../../domain/models/question_answer.dart';
import '../../domain/models/question_description.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/volume.dart';
import '../../domain/repository/quiz_repository.dart';

class FakeQuizRepositoryImpl extends QuizRepository with Logger {
  final _fakeTopics = [
    Topic(id: 1, title: "math", description: "basic calculation"),
    Topic(id: 2, title: "english", description: "tenses"),
    Topic(id: 3, title: "kotlin", description: "the beauty"),
  ];

  final _fakeVolumes = [
    Volume(id: 1, topicId: 1, title: 'basic calculation'),
    Volume(id: 2, topicId: 1, title: 'medium calculation'),
    Volume(id: 3, topicId: 1, title: 'advanced calculation'),
    Volume(id: 4, topicId: 1, title: 'basic recursion'),
    Volume(id: 5, topicId: 1, title: 'medium recursion'),
    // -----------------------------------------
    Volume(id: 6, topicId: 2, title: 'simple present'),
    Volume(id: 7, topicId: 2, title: 'continuous present'),
    Volume(id: 8, topicId: 2, title: 'past simple present'),
    Volume(id: 9, topicId: 2, title: 'present perfect tense'),
    // -----------------------------------------
    Volume(id: 10, topicId: 3, title: 'kotlin + android = ♥', quizType: QuizType.SINGLE_QUESTION_LIMIT_TIME, countdownInMillis: 10*60*1000),
    Volume(id: 11, topicId: 3, title: 'kotlin multi-platform', quizType: QuizType.MULTI_QUESTION_LIMIT_TIME, countdownInMillis: 10*60*1000),
    Volume(id: 12, topicId: 3, title: 'kotlin server-side', quizType: QuizType.SINGLE_QUESTION_NO_LIMIT_TIME),
  ];

  final _fakeQuestion = Question(
      id: 0,
      volumeId: 0,
      questionDescription: DescriptionOnly("who developed this app?"),
      questionAnswer: AnswerFromOptions(
          options: ["torrydo", "abc", "xyz", "hahaha"], position: 0));

  final List<Question> _fakeQuestions = [];

  FakeQuizRepositoryImpl() {
    int temp = 1;
    for (int i = 1; i <= 36; i++) {
      _fakeQuestions.add(
        _fakeQuestion.copyWith(
          id: i,
          volumeId: temp,
        ),
      );
      if (i % 3 == 0) {
        temp++;
      }
    }
  }

  @override
  Stream<List<Topic>> collectTopics() async* {
    e("return fake data");
    yield _fakeTopics;
  }

  @override
  Stream<List<Question>> collectQuestions() async* {
    e("return fake data");
    yield _fakeQuestions;
  }

  @override
  Stream<List<Question>> collectQuestionsByVolume(Volume volume) async* {
    e("return fake data");
    yield _fakeQuestions.filter((element) => element.volumeId == volume.id);
  }

  @override
  Stream<List<Volume>> collectVolumes() async* {
    e("return fake data");
    yield _fakeVolumes;
  }

  @override
  Stream<List<Volume>> collectVolumesByTopic(Topic topic) async* {
    e("return fake data");
    yield _fakeVolumes.filter((it) => it.topicId == topic.id);
  }

  @override
  List<Question> getQuestionsByVolume(Volume volume) {
    e("return fake data");

    // return _fakeQuestions.filter((it) => it.volumeId == volume.id).mapIndexed((e, index) => e.copyWith(
    //   questionDescription: DescriptionOnly(
    //     'who developed this app? id$index',
    //   ),
    //   questionAnswer: AnswerFromOptions(
    //     options: ["torrydo", "abc", "xyz", "hahaha"],
    //     position: 0,
    //   ),
    // ));

    if (volume.id == 4 ||
        volume.id == 1 ||
        volume.id == 2 ||
        volume.id == 3 ||
        volume.id == 5) {
      return [
        Question(
          id: 1,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('1+1'),
          questionAnswer:
              AnswerFromOptions(options: ['2', '4', '3', '1'], position: 0),
        ),
        Question(
          id: 2,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('2/0'),
          questionAnswer:
              AnswerFromOptions(options: ['0', '1', 'NaN', '2'], position: 2),
        ),
        Question(
          id: 3,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('0*2'),
          questionAnswer:
              AnswerFromOptions(options: ['2', '0', '0.5', '4'], position: 1),
        ),
        Question(
          id: 4,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('1 candy plus 1 candy'),
          questionAnswer: AnswerFromOptions(
              options: ['2 bananas', '1 candy', '2 sweeties', '2 candies'],
              position: 3),
        ),
        Question(
          id: 5,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('1/4 of a pizza'),
          questionAnswer: AnswerFromOptions(options: [
            'a quarter of pizza',
            'nothing left',
            '1 pizza',
            '4 pizzas'
          ], position: 0),
        )
      ];
    }
    if (volume.id == 6 || volume.id == 7 || volume.id == 8 || volume.id == 9) {
      return [
        Question(
          id: 6,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('A synonym of "big" is:'),
          questionAnswer: AnswerFromOptions(
              options: ["large", 'more', 'standard', 'less'], position: 0),
        ),
        Question(
          id: 7,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('A synonym of "buy" is:'),
          questionAnswer: AnswerFromOptions(
              options: ['price', 'sell', 'chill', 'purchase'], position: 3),
        ),
        Question(
          id: 8,
          volumeId: volume.id,
          questionDescription: DescriptionWithImage(
            "what is the man's shirt color?",
            imageSrc: 'assets/images/man_shirt.jpg',
          ),
          questionAnswer: AnswerFromOptions(
              options: ['red', 'black', 'blue', 'white'], position: 2),
        ),
        Question(
          id: 9,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('A synonym of "quickly" is:'),
          questionAnswer: AnswerFromOptions(
              options: ['slowly', 'happy', 'eating', 'speedily'], position: 3),
        ),
        Question(
          id: 10,
          volumeId: volume.id,
          questionDescription: DescriptionOnly('A synonym of "beautiful" is:'),
          questionAnswer: AnswerFromOptions(
              options: ['forget', 'pretty', 'friend', 'ugly'], position: 1),
        )
      ];
    }

    // if (volume.id == 10 || volume.id == 11 || volume.id == 12) {
    return [
      Question(
        id: 11,
        volumeId: volume.id,
        questionDescription: DescriptionWithImage(
            'You would like to print each score on its own line with its cardinal position. Without using var or val, which method allows iteration with both the value and its position?',
            imageSrc: 'assets/images/quiz_kotlin1.png'),
        questionAnswer: AnswerFromOptions(
          options: [
            ".withIndex()",
            '.forEachIndexed()',
            '.forEach()',
            '.forIndexes()'
          ],
          position: 0,
        ),
      ),
      Question(
        id: 12,
        volumeId: volume.id,
        questionDescription: DescriptionWithImage(
            'When the Airplane class is instantiated, it displays Aircraft = null, not Aircraft = C130 why?',
            imageSrc: 'assets/images/quiz_kotlin2.png'),
        questionAnswer: AnswerFromOptions(
          options: [
            'Classes are initialized in the same order they are in the file, therefore, Aircraft should appear after Airplane',
            "The code needs to pass the parameter to the base class's primary constructor. Since it does not, it receives a null",
            'Abstract function always returns null',
            'A superclass is initialized before its subclass. Therefore, name has not been set before it is rendered'
          ],
          position: 3,
        ),
      ),
      Question(
        id: 13,
        volumeId: volume.id,
        questionDescription: DescriptionOnly(
            "Kotlin interfaces and abstract classes are very similar. What is one thing abstract class can do that interfaces cannot?"),
        questionAnswer: AnswerFromOptions(
          options: [
            'Only abstract classes are inheritable by subclasses',
            'Only abstract classes can inherit from multiple superclasses',
            'Only abstract classes can have abstract methods',
            'Only abstract classes can store state'
          ],
          position: 3,
        ),
      ),
      Question(
        id: 14,
        volumeId: volume.id,
        questionDescription: DescriptionOnly(
          'Inside an extension function, what is the name of the variable that corresponds to the receiver object',
        ),
        questionAnswer: AnswerFromOptions(
          options: [
            'The variable is named it',
            'The variable is named this',
            'The variable is named receiver',
            'The variable is named default'
          ],
          position: 1,
        ),
      ),
      Question(
        id: 15,
        volumeId: volume.id,
        questionDescription: DescriptionWithImage(
            'Your application has an add function. How could you use its invoke methods and display the results?',
            imageSrc: 'assets/images/quiz_kotlin5.png'),
        questionAnswer: AnswerFromOptions(
          options: [
            'println(add(5,10).invoke())',
            'println(::add.invoke(5, 10))',
            'println(::add.invoke{5, 10})',
            'println(add.invoke(5,10))'
          ],
          position: 1,
        ),
      )
    ];
    // }
  }

  @override
  List<Volume> getVolumesByTopic(Topic topic) {
    e("return fake data");

    return _fakeVolumes.filter((it) => it.topicId == topic.id);
  }
}
