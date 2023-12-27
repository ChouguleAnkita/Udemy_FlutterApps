import 'dart:math';
import 'package:flutter/material.dart';

final randomizer=Random();

class DiceRoller extends StatefulWidget{
  
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
   return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>{
  var diceRoll=2;
  var activeImage='assets/images/dice-4.jpg';

  void rolldice(){
    setState(() {
      diceRoll=randomizer.nextInt(6)+1 ;//1 to 6
      activeImage='assets/images/dice-$diceRoll.png';
    });
  }
  @override
  Widget build(context){
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              activeImage,
              width: 300,
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: rolldice,
              child: const Text(
                "Roll Dice",
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(221, 3, 10, 35),
                ),
              ),
            ),
          ],
        );
  }
}