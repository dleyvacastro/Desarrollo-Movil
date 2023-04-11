import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/GameController.dart';
import 'Game.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Puntos y Famas',
      // theme: ThemeData(
      //   fontFamily: 'Michroma',
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Puntos y Famas'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Puntos y Famas',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Solitario'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Versus'),
                  ),
                ],
                onChanged: (value) {
                  controller.setMode(value as int);
                  setState(() {

                  });
                },
                hint: Text(controller.getMode()),
              ),
              controller.mode == 1 ? DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Facil'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Medio'),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('Dificil'),
                  ),
                ],
                onChanged: (value) {
                  controller.setDifficulty(value as int);
                  setState(() {

                  });
                },
                hint: Text(controller.getDifficulty()),
              ) : Container(),
              ElevatedButton(
                onPressed: () {
                  controller.validateGame();
                },
                child: const Text('Jugar'),
              ),

              Container(
                margin: const EdgeInsets.all(30),

                child: const Text(
                  'Game By: Daniel Leyva',
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
