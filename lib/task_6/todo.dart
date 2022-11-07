import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(
    this.id,
    this.content,
    this.judge,
    this.createDate,
  );
  String id;
  String content;
  int judge;
  Timestamp createDate;
}
