import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "third Party Library",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: true,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('communicationStatus');
  var _communicationStatus = "通信状況";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("通信状況の確認"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                  color: Colors.teal, shape: BoxShape.circle),
              child: Center(
                child: Text(_communicationStatus),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                print("押された");
                _getCommunicationStatus();
              },
              child: const Text("通信状況を測定"),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _getCommunicationStatus() async {
    String communicationStatus;
    try {
      final String result = await platform.invokeMethod('getCommunicationStatus');
      communicationStatus = result;
    } on PlatformException catch (e) {
      communicationStatus = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _communicationStatus = communicationStatus;
    });
  }
}
