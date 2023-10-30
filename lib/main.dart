import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Honey vibes',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;

  void _startVibration() {
    if (_timer != null) {
      _timer!.cancel();
    }

    // Fonction pour gérer les vibrations
    void handleVibration() {
      int count = 0;
      _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        if (count < 40) { // 20 secondes / 0.2 secondes = 100
          if (count % 2 == 0) {
            Vibration.vibrate(duration: 500, amplitude: 255); // Vibre pendant 0.2 secondes
          }
        } else if (count >= 45) { // 5 secondes / 0.2 secondes = 25, donc 100 + 10 = 110
          count = 0; // Réinitialise le compteur
        }
        count++;
      });
    }

    handleVibration();
  }

  void _stopVibration() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    Vibration.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: const Text('Honey vibes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                icon: const Icon(
                  Icons.favorite_rounded,
                  size: 190.0,
                  color: Color.fromARGB(255, 232, 174, 205),
                ),
              label: const Text(""),
              onPressed: _startVibration,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), // This gives the round shape
                padding: const EdgeInsets.only(top: 25,bottom: 10, left: 27, right: 20), // Adjust this value to change the overall size of the button
                backgroundColor: Colors.pink, // This is the background color
                ),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.stop_circle_rounded,
                size: 70.0,
              ),
              label: const Text(""),
              onPressed: _stopVibration,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), // This gives the round shape
                padding: const EdgeInsets.only(top: 20,bottom: 20, left: 24, right: 20), // Adjust this value to change the overall size of the button
                backgroundColor: Colors.black87, // This is the background color
              ),
            ),
            const SizedBox(height: 20),
            const Text("For Honey",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.copyright_outlined),
                Text("Copyright 2023 HN")
              ],
            )
          ],
        ),
      ),
    );
  }
}
