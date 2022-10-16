import 'package:flutter/material.dart';

// ignore: camel_case_types
class Task3_2 extends StatefulWidget {
  // 値受け取りよう変数
  final String image;
  final String music;
  final String name;

  const Task3_2(
      {Key? key, required this.image, required this.music, required this.name})
      : super(key: key);

  @override
  State<Task3_2> createState() => _Task3_2();
}

// ignore: camel_case_types
class _Task3_2 extends State<Task3_2> {
  // 変数大義
  var _status = true;
  var _sliderValue = 0.0;
  DateTime _elapsedTime = DateTime(2022, 01, 01, 00, 00, 00);
  DateTime _remainingTime = DateTime(2022, 01, 01, 00, 05, 00);
  late Duration duration;
  int difference = 0;

  // 再生・停止ボタン用
  void onTapStart() {
    setState(() {
      _status = true;
    });
  }

  void onTapStop() {
    setState(() {
      _status = false;
    });
  }

  // カーソル移動時と同時に時間も変更する
  void timer(double value) {
    setState(() {
      // カーソルの移動前と移動後の差分を格納
      difference = (_sliderValue - value).ceil();
      duration = Duration(seconds: difference);

      // 差分を稼働時間と残時間に加算・減算する
      _elapsedTime = _elapsedTime.add(-duration);
      _remainingTime = _remainingTime.add(duration);

      // カーソルの移動後の値を格納
      _sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        body: Center(
            child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.navigate_before),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: 330,
              width: 330,
              child: Image.network(
                widget.image,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.music,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Container(),
            Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
              thumbColor: Colors.white,
              value: _sliderValue,
              min: 0,
              max: 300,
              divisions: 300,
              onChanged: (double value) {
                timer(value.roundToDouble());
              },
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _elapsedTime.toString().substring(14, 19),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _remainingTime.toString().substring(14, 19),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 30,
                ),
                _status == true
                    ? IconButton(
                        icon: const Icon(Icons.pause_circle),
                        iconSize: 80,
                        color: Colors.white,
                        onPressed: () {
                          onTapStop();
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.play_circle),
                        iconSize: 80,
                        color: Colors.white,
                        onPressed: () {
                          onTapStart();
                        },
                      ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 50,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            )
          ]),
        )));
  }
}
