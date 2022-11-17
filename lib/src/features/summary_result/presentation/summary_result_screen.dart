import 'package:flutter/material.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_provider.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

class SummaryResultScreen extends StatefulWidget {
  const SummaryResultScreen({Key? key}) : super(key: key);

  @override
  State<SummaryResultScreen> createState() => _SummaryResultScreenState();
}

class _SummaryResultScreenState extends State<SummaryResultScreen> {
  late SummaryProvider _summaryProvider;

  @override
  Widget build(BuildContext context) {
    _summaryProvider = context.provider();

    return Material(
      color: Colors.blueGrey,
      child: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Center(
      child: Container(child: () {
        int validNumber = _summaryProvider.validQuestionCount();
        if (validNumber == _summaryProvider.questions.length) {
          return const Text('you win this quiz');
        } else {
          return Text(
              'valid answer = $validNumber/${_summaryProvider.questionLength}');
        }
      }()),
    );
  }
}
