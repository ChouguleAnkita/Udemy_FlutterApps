import 'package:flutter/material.dart';
import 'package:rolldice_app/gradient_container.dart';


class RollDice extends StatelessWidget{

  const RollDice({super.key});

  @override
  Widget build(context){
    return const MaterialApp(
      home: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 83, 182, 170),
        body: GradientContainer(
          colors: [Colors.blueAccent, Colors.teal],
        ),
      ),
    );
  }
}