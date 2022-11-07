import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/task_6/todo.dart';

class TodoListModel extends ChangeNotifier {
  // 変数定義
  late int editButtonStatus = 0;
  late TextEditingController addTextController = TextEditingController();
  late TextEditingController editTextController =
      TextEditingController(text: beforeText);
  late String beforeText;
  late String addText;
  late String editText;

  // Todo用変数
  late String id;
  late String content;
  late int judge;
  late Timestamp createDate;

  // TodoList格納用
  List<Todo>? todos;

  // todoリストを返す
  List<Todo>? fetchTodos() {
    FirebaseFirestore.instance
        .collection('todos')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      final List<Todo> todos = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        {
          id = document.id;
          content = data['content'];
          judge = data['judge'];
          createDate = data['createDate'];
        }
        return Todo(
          id,
          content,
          judge,
          createDate,
        );
      }).toList();
      this.todos = todos;
    });
    return todos;
  }

  // テキスト格納変数更新処理
  void addTexts(String text) {
    addText = text;
    notifyListeners();
  }

  void editTexts(String text) {
    editText = text;
    notifyListeners();
  }

  // ステータス更新処理
  void editButtonStatusOn() {
    if (editButtonStatus == 0) {
      editButtonStatus = 1;
    } else {
      editButtonStatus = 0;
    }
    notifyListeners();
  }

  // Todo削除処理
  void deleteTodo(String id) async {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
    notifyListeners();
  }

  // Todo追加処理
  void addTodo() async {
    await FirebaseFirestore.instance.collection('todos').doc().set({
      'content': addText,
      'createDate': DateTime.now(),
      'judge': 0,
    });
    notifyListeners();
  }

  // Todo実施済更新処理
  void updateTodoStatusComplete(String todoId, int judge) async {
    // ignore: non_constant_identifier_names
    final TodoFireBase =
        FirebaseFirestore.instance.collection('todos').doc(todoId);
    if (judge == 0) {
      await TodoFireBase.update({
        'judge': 1, //1:Todo実施済
      });
    } else {
      await TodoFireBase.update({
        'judge': 0, //1:Todo実施済
      });
    }
    notifyListeners();
  }

  // Todo更新処理
  void updateTodo(String updateId) async {
    await FirebaseFirestore.instance.collection('todos').doc(updateId).update({
      'content': editText,
    });
  }
}
