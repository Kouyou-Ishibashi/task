import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task/task_4/post.dart';
import 'package:flutter_task/task_4/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/task_4/signup_page.dart';
import 'package:provider/provider.dart';

import 'add_page.dart';

// ignore: must_be_immutable
class PostPage extends StatelessWidget {
  PostPage({Key? key}) : super(key: key);
  final _uid = FirebaseAuth.instance.currentUser?.uid.toString();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostModel>(
      create: (_) => PostModel()..fetchPostList(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.output_sharp),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ログアウトしました。')),
              );

              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => signUpPage(),
                  ));
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPage(),
                    ));
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<PostModel>(builder: (context, model, child) {
            final List<Post>? posts = model.posts;

            if (posts == null) {
              return const Text('投稿なし');
            }
            final List<Widget> widgets = posts
                .map(
                  (posts) => posts.accountId == _uid
                      ? Container(
                          margin: const EdgeInsets.all(5),
                          decoration:
                              const BoxDecoration(color: Colors.lightGreen),
                          child: ListTile(
                            title: Text(
                              posts.content,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: ListTile(
                            title: Text(
                              posts.content,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
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
      ),
    );
  }
}
