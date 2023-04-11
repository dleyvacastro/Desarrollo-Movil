import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/GameController.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(controller.getMode() == '1' ? 'Solitario' : 'Versus'),
          ),
          body: Center(
            child: Column(
              children: [
                Row(
                  children: List.generate(controller.number.length, (index) {
                    setState(() {

                    });
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        controller.number[index],
                        style: const TextStyle(fontSize: 50),
                      ),
                    );
                  }),
                ),
              ],
            ),
          )
      ),
    );
  }
}
