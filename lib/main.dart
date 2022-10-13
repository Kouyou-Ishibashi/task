import 'package:flutter/material.dart';
import 'package:flutter_task/task_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // appBarTheme: const AppBarTheme(
          //     color: Colors.white,
          //     elevation: 0,
          //     titleTextStyle: TextStyle(
          //         color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          //     iconTheme: IconThemeData(color: Colors.black)),
          // primaryColor: const Color(0xff6c755),
          // scaffoldBackgroundColor: Colors.white,
          ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Task1()));
                },
                child: const Text('課題1'))
          ],
        ),
      ),
    );
  }
}
