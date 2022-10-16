import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class signUprModel extends ChangeNotifier {
  //コントローラ変数定義
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //変数定義
  String? email;
  String? password;
  bool isLoading = false;

  //ログイン情報取得
  final FirebaseAuth auth = FirebaseAuth.instance;

  //ローディング
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  //メールアドレス登録
  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  //パスワード登録
  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  //新規登録
  Future signUp() async {
    email = emailController.text;
    password = passwordController.text;

    if (email != null && password != null) {
      // firebaseauthでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      if (user != null) {
        final doc = FirebaseFirestore.instance.collection('accounts').doc();
        await doc.set({
          'accountId': user.uid,
          'email': email,
        });
      }
    }
  }
}
