import 'package:flutter/material.dart';

class AnswerOption extends StatefulWidget {
  final int id;
  final int userAnswer;
  final Function(int)? onClick;
  final String description;

  const AnswerOption(
      {Key? key,
      required this.id,
      required this.userAnswer,
      required this.description,
      this.onClick})
      : super(key: key);

  @override
  State<AnswerOption> createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: (){
          if(widget.userAnswer == widget.id){
            return Colors.yellow;
          }else{
            return Colors.blueAccent;
          }
        }(),
        padding: const EdgeInsets.all(10),
        child: Center(child: Text(widget.description)),
      ),
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!(widget.id);
        }
      },
    );
  }
}
