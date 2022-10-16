import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: camel_case_types
class AddModel extends ChangeNotifier {
  //コントローラ変数定義
  final contentController = TextEditingController();

  // 処理日格納
  late DateTime now = DateTime.now();
  final DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ss');
  late String createDate = format.format(now);

  //変数定義
  String? content;
  bool isLoading = false;

  //ログイン情報取得
  final _uid = FirebaseAuth.instance.currentUser?.uid.toString();

  //ローディング
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  //投稿文字セット
  void setContent(String content) {
    this.content = content;
    notifyListeners();
  }

  //新規登録
  Future input() async {
    content = contentController.text;

    if (content != null) {
      final doc = FirebaseFirestore.instance.collection('posts').doc();
      await doc.set(
          {'accountId': _uid, 'content': content, 'createDate': createDate});
    }
  }
}
