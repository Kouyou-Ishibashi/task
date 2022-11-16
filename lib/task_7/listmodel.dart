import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/task_7/bookmodel/book.dart';

// 変数定義(グローバル変数)
String inputgenre = '指定なし';
String searchText = '';
TextEditingController searchTextController = TextEditingController();
String selectedValue = "指定なし";
final genres = ["指定なし", "人文・思想", "歴史・地理", "科学・工学", "文学・評論", "アート・建築"];

// データ参照(StreamProvider)
final bookListStreamProvider = StreamProvider.autoDispose((_) {
  Query<Map<String, dynamic>> ref =
      FirebaseFirestore.instance.collection('books');
  // ジャンルで絞り込み
  if (inputgenre != '指定なし') {
    ref = FirebaseFirestore.instance
        .collection('books')
        .where('genre', isEqualTo: inputgenre);
  }
  final bookListProvider = ref.snapshots().map((snapshot) => snapshot.docs
      .map((doc) => doc.data())
      .map((data) => Book(
          title: data['title'],
          subtitle: data['subtitle'],
          genre: data['genre'],
          author: data['author']))
      .toList());
  return bookListProvider;
});

class ListModel extends ChangeNotifier {
  // テキスト格納変数更新処理
  void inputText(String text) {
    searchText = text;
    notifyListeners();
  }

  // ジャンル格納変数更新処理
  void inpuGenre(String genreText) {
    selectedValue = genreText;
    inputgenre = genreText;
    notifyListeners();
  }
}
