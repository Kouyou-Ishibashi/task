import 'package:flutter/material.dart';
import 'package:flutter_task/main.dart';
import 'package:flutter_task/task_5/animal.dart';
import 'package:provider/provider.dart';

import 'addanimal.dart';
import 'animallist_model.dart';

// ignore: must_be_immutable
class AnimalListPage extends StatefulWidget {
  const AnimalListPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AnimalListPage createState() => _AnimalListPage();
}

class _AnimalListPage extends State<AnimalListPage> {
  // 変数定義
  late String _selectedValue = '';
  // ポップアップのリスト定義
  final _usStates = ["犬のみ", "猫のみ", "年齢：昇順", "年齢：降順"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AnimalListModel>(
      create: (_) => AnimalListModel()..fetchAnimalList(_selectedValue),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_selectedValue),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const MyApp();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const Offset begin = Offset(-1.0, 0.0);
                      const Offset end = Offset.zero;
                      final Animatable<Offset> tween =
                          Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: Curves.easeInOut));
                      final Animation<Offset> offsetAnimation =
                          animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              }),
          actions: <Widget>[
            Consumer<AnimalListModel>(builder: (context, model, child) {
              return PopupMenuButton<String>(
                initialValue: _selectedValue,
                onSelected: (String select) {
                  setState(() {
                    _selectedValue = select;
                  });
                  model.fetchAnimalList(_selectedValue);
                },
                itemBuilder: (BuildContext context) {
                  return _usStates.map((String menu) {
                    return PopupMenuItem(
                      value: menu,
                      child: Text(menu),
                    );
                  }).toList();
                },
                child: const Icon(Icons.sort),
              );
            }),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: Center(
          child: Consumer<AnimalListModel>(builder: (context, model, child) {
            final List<AnimalA>? animals = model.animals;

            if (animals == null) {
              return const Text('投稿なし');
            }
            final List<Widget> widgets = animals
                .map(
                  (animals) => Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: ListTile(
                      title: Text(
                        '名前：${animals.name} 品種：${animals.type} 性別：${animals.gender} 年齢：${animals.age}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddAnimal()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
