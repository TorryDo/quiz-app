import 'package:flutter/material.dart';
import 'package:quiz_app/core/hook.dart';
import 'package:quiz_app/src/features/quiz/presentation/view/question_option.dart';
import 'package:quiz_app/utils/logger.dart';

abstract class QuestionAnswer {

  @protected
  Function(QuestionSideEffect)? postSideEffect;

  void collectSideEffect(Function(QuestionSideEffect) event){
    postSideEffect = event;
  }

  bool isValid();

  void setUserAnswer(dynamic any);

  Widget renderInput();
}

abstract class QuestionSideEffect{
  QuestionSideEffect();
}
class AnswerValid extends QuestionSideEffect{
  AnswerValid();
}
class AnswerInValid extends QuestionSideEffect{
  AnswerInValid();
}


class AnswerFromOptions extends QuestionAnswer with Logger {
  List<String> options = <String>[];
  int position;

  int userAnswer = -1;

  AnswerFromOptions({required this.options, required this.position});

  @override
  bool isValid() {
    return userAnswer == position;
  }

  @override
  void setUserAnswer(any) {
    if (any! is int) throw Exception("answer must be int type");

    userAnswer = any as int;
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget renderInput() {
    return AnswerFromOptionsView(
      options: options,
      previousUserAnswer: userAnswer,
      onOptionClick: (position) {
        userAnswer = position;
      },
      onConfirmClick: (){
        if(postSideEffect != null) {
          if(isValid()){
            postSideEffect!(AnswerValid());
          }else{
            postSideEffect!(AnswerInValid());
          }
        }
      },
    );
  }
}

class AnswerFromOptionsView extends StatefulWidget {
  final List<String> options;
  final Function(int)? onOptionClick;
  final Function? onConfirmClick;
  final int previousUserAnswer;

  const AnswerFromOptionsView(
      {Key? key,
      required this.options,
      this.onOptionClick,
      this.onConfirmClick,
      required this.previousUserAnswer})
      : super(key: key);

  @override
  State<AnswerFromOptionsView> createState() => _AnswerFromOptionsViewState();
}

class _AnswerFromOptionsViewState extends State<AnswerFromOptionsView>
    with Hook, Logger {
  int userAnswer = -1;

  @override
  void initState() {
    super.initState();

    setState(() {
      userAnswer = widget.previousUserAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onUserClick(int id) {
      if (widget.onOptionClick != null) {
        widget.onOptionClick!(id);
        setState(() {
          userAnswer = id;
        });
      }
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _option(0, onUserClick)),
            const SizedBox(width: 10),
            Expanded(child: _option(1, onUserClick))
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _option(2, onUserClick)),
            const SizedBox(width: 10),
            Expanded(child: _option(3, onUserClick))
          ],
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (widget.onConfirmClick != null) {
                widget.onConfirmClick!();
              }
            },
            child: const Text('check'),
          ),
        )
      ],
    );
  }

  Widget _option(int id, Function(int) onClick) {
    return AnswerOption(
      id: id,
      userAnswer: userAnswer,
      description: widget.options[id],
      onClick: onClick,
    );
  }
}
