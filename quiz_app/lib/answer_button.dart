import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answerText;
  final Function() onTab;

  const AnswerButton(
      {super.key, required this.onTab, required this.answerText});

  @override
  Widget build(context) {
    return Container(
      margin:const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onTab,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 26, 1, 47),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )),
        child: Text(answerText,textAlign: TextAlign.center,),
      ),
    );
  }
}
