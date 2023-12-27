import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  final void Function(String answer) onSelectAnswer;
  // const QuestionScreen({key}):super(key: key);
  const QuestionScreen({super.key, required this.onSelectAnswer});

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

//private class
class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    setState(() {
      widget.onSelectAnswer(selectedAnswer);
      currentQuestionIndex = currentQuestionIndex + 1;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 207, 199, 215),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            //spread oreator(...)
            //  ...currentQuestion.answers.map((answer){
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return AnswerButton(
                answerText: answer,
                onTab: () {
                  answerQuestion(answer);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
