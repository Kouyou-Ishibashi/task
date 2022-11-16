import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/task_7/bookmodel/book.dart';
import 'package:flutter_task/task_7/listmodel.dart';
import 'package:flutter_task/task_7/searchpage.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // riverpod設定
      home: const ProviderScope(
        child: BookListPage(),
      ),
    );
  }
}

class BookListPage extends ConsumerWidget {
  const BookListPage({Key? key}) : super(key: key);
  final String title = '蔵書一覧';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booklist = ref.watch(bookListStreamProvider);
    final input = searchText;

    // ignore: unnecessary_null_comparison
    if (booklist == null) {
      return Scaffold(
          appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(title),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(title),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: booklist.when(
        data: (booklist) {
          return ListView.builder(
              itemCount: booklist.length,
              itemBuilder: (context, index) {
                Book books = booklist[index];
                // キーワードが設定されていない またはタイトル,サブタイトル,著者に含まれる場合、表示する
                if (input == '' ||
                    (books.title.contains(input) == true ||
                        books.subtitle.contains(input) == true ||
                        books.author.contains(input) == true)) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5, left: 5),
                    padding: const EdgeInsets.all(0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          '${books.title} - ${books.author}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(books.subtitle),
                      ),
                    ),
                  );
                  // 上記以外は表示なし
                } else {
                  return const SizedBox(
                    height: 0,
                    child: Text(''),
                  );
                }
              });
        },
        loading: () {
          return const Center(
            child: Text('読込中...'),
          );
        },
        error: (e, stackTrace) {
          return Center(
            child: Text(e.toString()),
          );
        },
      ),
    );
  }
}
