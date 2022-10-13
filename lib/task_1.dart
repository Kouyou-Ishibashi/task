import 'package:flutter/material.dart';

class Task1 extends StatelessWidget {
  const Task1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                // 背景画像設定
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.9),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage(
                      'images/rebe-adelaida-zunQwMy5B6M-unsplash.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                height: 320,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 画像右上のアイコン設定
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.share),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.white.withOpacity(0.9),
                              )
                            ],
                          )),
                    ),
                    // 画像左下のコメント設定
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 120, left: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Venice',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.place,
                                      size: 16,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    Text(
                                      'Italy',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                // 真ん中のアイコンボタン設定
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '★★★★☆',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 25,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        ' 4.0',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                        ))
                  ],
                )),
            Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.wifi),
                            onPressed: () {},
                            iconSize: 30,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text('WiFi'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.flatware),
                            onPressed: () {},
                            iconSize: 30,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text('キッチン'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.beach_access),
                            onPressed: () {},
                            iconSize: 30,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text('ビーチ'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {},
                            iconSize: 30,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text('その他'),
                        )
                      ],
                    ),
                  ],
                )),
            // 詳細部設定
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    '詳細',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 20),
                  padding: const EdgeInsets.all(14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: const Text(
                    'イタリア共和国北東部に位置する都市で、その周辺地域を含む人口薬26万人の基礎自治体（コムーネ）。ヴェネト州の州都、ヴェネツィア県の県都である。ヴの表記によりベネチアと表記されることもある。中世にはヴェネツィア共和国の首都として栄えた都市で、「アドリア海の女王」「水の都」などの別名を持つ。英語では「Venice」と呼ばれ。これに由来して日本語でもヴェニス、ベニスと呼ばれることもある。',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
            // ボタン設定
            Container(
                margin: const EdgeInsets.only(top: 5),
                height: 50,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blueAccent,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'ホテルを予約する',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
