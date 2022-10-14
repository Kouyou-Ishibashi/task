import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Task2 extends StatefulWidget {
  const Task2({Key? key}) : super(key: key);

  @override
  State<Task2> createState() => _Task2();
}

class _Task2 extends State<Task2> {
  // 変数定義(数値の計算用)
  late double _number1 = 0.0;
  late double _number2 = 0.0;
  late double _result = 0.0;

  // 変数定義(四則演算)
  final _operator1 = '+';
  final _operator2 = '-';
  final _operator3 = '×';
  final _operator4 = '÷';

  // 変数定義(入力値)
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  // 計算式
  void calculation(String calculation) {
    setState(() {
      if (calculation == '+') {
        _result = (_number1 + _number2);
      } else if (calculation == '-') {
        _result = (_number1 - _number2);
      } else if (calculation == '×') {
        _result = (_number1 * _number2);
      } else {
        _result = (_number1 / _number2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator'),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                ),
                width: 120,
                child: TextField(
                  controller: controller1,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (text) {
                    _number1 = double.parse(text);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                ),
                width: 120,
                child: TextField(
                  onChanged: (text) {
                    _number2 = double.parse(text);
                  },
                  controller: controller2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Text('結果:${_result.toStringAsFixed(1).toString()}'),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 70,
                child: ElevatedButton(
                  child: Text(
                    _operator1,
                    style: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    calculation(_operator1);
                  },
                ),
              ),
              SizedBox(
                width: 70,
                child: ElevatedButton(
                  child: Text(
                    _operator2,
                    style: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    calculation(_operator2);
                  },
                ),
              ),
              SizedBox(
                width: 70,
                child: ElevatedButton(
                  child: Text(
                    _operator3,
                    style: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    calculation(_operator3);
                  },
                ),
              ),
              SizedBox(
                width: 70,
                child: ElevatedButton(
                  child: Text(
                    _operator4,
                    style: const TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    calculation(_operator4);
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
