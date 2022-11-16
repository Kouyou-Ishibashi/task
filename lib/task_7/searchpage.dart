import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/task_7/listpage.dart';

import 'listmodel.dart';

// ignore: non_constant_identifier_names
final SearchProvider = ChangeNotifierProvider.autoDispose((ref) => ListModel());

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: SearchSortPage(),
    );
  }
}

// ignore: must_be_immutable
class SearchSortPage extends ConsumerWidget {
  const SearchSortPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchProvider = ref.watch(SearchProvider);
    final keyword = searchText;
    final selectedValues = selectedValue;
    final items = genres;

    return Scaffold(
        appBar: AppBar(
          title: const Text('検索条件'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const ListPage();
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
            },
          ),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Text(
              '検索条件',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('ジャンル'),
            DropdownButton<String>(
              value: selectedValues,
              items: items
                  .map((String list) =>
                      DropdownMenuItem(value: list, child: Text(list)))
                  .toList(),
              onChanged: (value) {
                searchProvider.inpuGenre(value!);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'フィルター',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(right: 80, left: 80, top: 20),
              child: TextFormField(
                initialValue: keyword,
                decoration: const InputDecoration(
                    labelText: 'キーワード',
                    border: OutlineInputBorder(),
                    hintText: 'キーワード'),
                onChanged: (value) {
                  searchProvider.inputText(value);
                },
              ),
            )
          ],
        )));
  }
}
