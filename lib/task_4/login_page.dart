import 'package:flutter_task/task_4/post_page.dart';

import 'login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ログインページ'),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: model.emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'メールアドレス',
                    ),
                    onChanged: (text) {
                      model.setEmail(text);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: model.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'パスワード',
                    ),
                    onChanged: (text) {
                      model.setPassword(text);
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
                      await model.login();
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
                    "ログイン",
                  ),
                ),
              ],
            );
            // );
          }),
        ),
      ),
    );
  }
}
