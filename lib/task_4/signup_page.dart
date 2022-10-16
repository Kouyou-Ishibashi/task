import 'package:flutter_task/task_4/post_page.dart';
import 'package:flutter_task/task_4/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

// ignore: must_be_immutable, camel_case_types
class signUpPage extends StatelessWidget {
  bool isObscure = true;

  signUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<signUprModel>(
      create: (_) => signUprModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('登録ページ'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Consumer<signUprModel>(builder: (context, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
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
                      await model.signUp();
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
                    "ユーザー登録",
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    '既にアカウントをお持ちですか？',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
