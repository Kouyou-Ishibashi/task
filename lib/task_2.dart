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

  // 計算式(割り算の時、どちらかが0だった場合は0.0を入れる)
  void calculation(String calculation) {
    setState(() {
      if (calculation == '+') {
        _result = (_number1 + _number2);
      } else if (calculation == '-') {
        _result = (_number1 - _number2);
      } else if (calculation == '×') {
        _result = (_number1 * _number2);
      } else {
        if (_number1 == 0.0 || _number2 == 0.0) {
          _result = 0.0;
        } else {
          _result = (_number1 / _number2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 120,
                child: TextField(
                  controller: controller1,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (text) {
                    if (text != '') {
                      _number1 = double.parse(text);
                    } else {
                      _number2 = 0.0;
                    }
                  },
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 120,
                child: TextField(
                  onChanged: (text) {
                    if (text != '') {
                      _number2 = double.parse(text);
                    } else {
                      _number2 = 0.0;
                    }
                  },
                  controller: controller2,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(
                width: 10,
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
