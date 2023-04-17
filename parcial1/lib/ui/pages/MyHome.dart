import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial1/themes.dart';

import '../controller/GameController.dart';
import 'Game.dart';

class MyHome extends StatefulWidget {
  @override
  State<MyHome> createState() => _AppState();
}

class _AppState extends State<MyHome> {
  GameController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.myhomeSetState.value = () {
      setState(() {});
    };

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Puntos y Famas',
        theme: gameTheme,
        home: Scaffold(
            // appBar: AppBar(
            //   title: const Text('Puntos y Famas'),
            // ),
            body: Builder(
                builder: (context) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(30),
                            child: Text(
                              'Puntos y Famas',
                              // style: TextStyle(
                              //     fontSize: 50,
                              //     fontWeight: FontWeight.bold,
                              //     color: Colors.blue),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          controller.startedVersus.value
                              ? Container(
                                  child: Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    "Intentos utilizados: ${controller.getTries()}",
                                  ),
                                )
                              : Container(),
                          Container(
                              margin: const EdgeInsets.all(10),
                              child: DropdownButton(
                                items: !controller.startedVersus.value
                                    ? [
                                        const DropdownMenuItem(
                                          value: 1,
                                          child: Text('Solitario'),
                                        ),
                                        const DropdownMenuItem(
                                          value: 2,
                                          child: Text('Versus'),
                                        ),
                                      ]
                                    : [
                                        const DropdownMenuItem(
                                          value: 2,
                                          child: Text('Versus'),
                                        ),
                                      ],
                                onChanged: (value) {
                                  controller.setMode(value as int);
                                  setState(() {});
                                },
                                hint: Text(controller.getMode()),
                              )),
                          controller.mode == 1
                              ? DropdownButton(
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
                                    DropdownMenuItem(
                                      value: 4,
                                      child: Text('Letal'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    controller.setDifficulty(value as int);
                                    setState(() {});
                                  },
                                  hint: Text(controller.getDifficulty()),
                                )
                              : Container(),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                controller.validateGame();
                              },
                              child: const Text('Jugar'),
                            ),
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
                    ))));
  }
}
