import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: !true,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Totally not a spyware. That uses material 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var radius;
  var showCoords = false;
  // text controller for the radius input
  final radiusController = TextEditingController();

  List getCoords(radius, lat, long){
    // generate random coordinates within a given radius of a central point
    var r = radius*sqrt(Random().nextDouble());
    var theta = Random().nextDouble()*2*pi;
    var x = lat + r*cos(theta);
    var y = long + r*sin(theta);
    return [x,y];

  }

  Future<List> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return [position.latitude, position.longitude];
    } else {
      return ['permission denied'];
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: TextField(
                controller: radiusController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Radius',
                ),
                onSubmitted: (String value) async {
                  radius = double.parse(value);
                  showCoords = true;
                  print(radius);
                  setState(() {

                  });
                }
              ),
            ),
            SizedBox(
              child: Center(
                child: showCoords ? FutureBuilder(
                    future: getLocation(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        var newCords = getCoords(radius, snapshot.data![0], snapshot.data![1]);
                        return Column(
                          children: [
                            Text(
                            // print with 2 decimal places
                              "Original Cods: ${snapshot.data![0].toStringAsFixed(2)}, ${snapshot.data![1].toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              "New Cords: ${newCords[0].toStringAsFixed(2)}, ${newCords[1].toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Distance: ${sqrt(pow(snapshot.data![0]-newCords[0],2)+pow(snapshot.data![1]-newCords[1],2)).toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "${snapshot.error}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        );
                      }
                      return const CircularProgressIndicator();
                    }) : Container(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
