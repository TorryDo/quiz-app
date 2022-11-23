import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final String description;

  const DescriptionText({Key? key, required this.description})
      : super(key: key);

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.description, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}
