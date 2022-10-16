import 'package:flutter_task/task_4/post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_model.dart';

// ignore: must_be_immutable, camel_case_types
class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('投稿ページ'),
        ),
        body: Center(
          child: Consumer<AddModel>(builder: (context, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: model.contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'コメント',
                    ),
                    onChanged: (text) {
                      model.setContent(text);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // 開始プログレスインジケーター
                    model.startLoading();

                    try {
                      await model.input();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostPage(),
                          ));
                    } catch (e) {
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(e.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } finally {
                      // 終了プログレスインジケーター
                      model.endLoading();
                    }
                  },
                  child: const Text(
                    "投稿する",
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
