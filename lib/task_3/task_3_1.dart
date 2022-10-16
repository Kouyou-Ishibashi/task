import 'package:flutter/material.dart';
import 'package:flutter_task/task_3/task_3_2.dart';

// ignore: camel_case_types
class Task3_1 extends StatefulWidget {
  const Task3_1({Key? key}) : super(key: key);

  @override
  State<Task3_1> createState() => _Task3_1();
}

// ignore: camel_case_types
class _Task3_1 extends State<Task3_1> {
  // 変数定義(ボトムナビゲーターバー用)
  var _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // おすすめリスト作成
  Map music = {
    0: {
      'image':
          'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/513EQvSc86L._AC_.jpg',
      'music': 'おかずのごはん',
      'name': 'RADWIMPS'
    },
    1: {
      'image':
          'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61C2Rv5kBSL._AC_SX679_.jpg',
      'music': '君の名は',
      'name': 'RADWIMPS'
    },
    2: {
      'image':
          'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61XVlC1jDTL._AC_SX679_.jpg',
      'music': '発展途上',
      'name': 'RADWIMPS'
    },
    3: {
      'image':
          'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/81dNYTaJ46L._AC_SX569_.jpg',
      'music': 'アルトコロニーの定理',
      'name': 'RADWIMPS'
    },
    4: {
      'image':
          'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/41zUeSv9OuL._AC_.jpg',
      'music': '無人島に持っていき忘れた一枚',
      'name': 'RADWIMPS'
    },
  };

  // カテゴリーリスト
  List<String> category = [
    'クラシック',
    'カントリー',
    'ポップ',
    'ロック',
    'ジャズ',
    'パンク',
  ];

  // カテゴリーのカラー
  Map color = {
    0: {'color1': Colors.purple, 'color2': Colors.black},
    1: {'color1': Colors.yellow, 'color2': Colors.brown},
    2: {'color1': Colors.pink, 'color2': Colors.red},
    3: {'color1': Colors.lightBlue, 'color2': Colors.blue},
    4: {'color1': Colors.lightGreen, 'color2': Colors.greenAccent},
    5: {'color1': Colors.redAccent, 'color2': Colors.pink},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ホーム'),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 70, 70, 70),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'あなたへのおすすめ',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: music.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Task3_2(
                                              image: music[index]['image'],
                                              music: music[index]['music'],
                                              name: music[index]['name'],
                                            )));
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.network(
                                  music[index]['image'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                music[index]['music'],
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                music[index]['name'],
                                style: const TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'カテゴリー',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 210,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: const Alignment(-1.0, -1.0),
                            end: const Alignment(1.0, 1.0),
                            colors: <Color>[
                              color[index]['color1'],
                              color[index]['color2'],
                            ],
                            stops: const [
                              0,
                              1,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          category[index],
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        )));
                  },
                  shrinkWrap: true,
                ),
              ),
              Row(
                children: const [],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: '検索',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_play,
                ),
                label: 'プレイリスト'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                ),
                label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _onTap,
        ));
  }
}
