import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/task_4/post.dart';

// ignore: camel_case_types
class PostModel extends ChangeNotifier {
  // 変数定義
  late String accountId;
  late String content;
  late String createDate;

  //投稿リスト取得用変数
  List<Post>? posts;

  void fetchPostList() {
    final Stream<QuerySnapshot> childrenStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createDate', descending: false)
        .snapshots();
    childrenStream.listen((QuerySnapshot snapshot) {
      final List<Post> posts = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        {
          accountId = data['accountId'];
          content = data['content'];
          createDate = data['createDate'];
        }
        return Post(
          accountId,
          content,
          createDate,
        );
      }).toList();
      this.posts = posts;
      notifyListeners();
    });
  }
}
