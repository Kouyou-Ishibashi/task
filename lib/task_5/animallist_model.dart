import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'animal.dart';

// ignore: camel_case_types
class AnimalListModel extends ChangeNotifier {
  // 変数定義
  late String name;
  late String animal;
  late String type;
  late String gender;
  late int age;
  late String select = '';

  //投稿リスト取得用変数
  List<AnimalA>? animals;

  //  アニマルリスト抽出処理
  void fetchAnimalList(selected) {
    // 犬のみ抽出
    if (selected == '犬のみ') {
      final Stream<QuerySnapshot> childrenStream = FirebaseFirestore.instance
          .collection('animals')
          .where('animal', isEqualTo: '犬')
          .snapshots();
      childrenStream.listen((QuerySnapshot snapshot) {
        final List<AnimalA> animals =
            snapshot.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          {
            name = data['name'];
            animal = data['animal'];
            type = data['type'];
            gender = data['gender'];
            age = data['age'];
          }
          return AnimalA(
            name,
            animal,
            type,
            gender,
            age,
          );
        }).toList();
        this.animals = animals;
        notifyListeners();
      });
      //　猫のみ抽出
    } else if (selected == '猫のみ') {
      final Stream<QuerySnapshot> childrenStream = FirebaseFirestore.instance
          .collection('animals')
          .where('animal', isEqualTo: '猫')
          .snapshots();
      childrenStream.listen((QuerySnapshot snapshot) {
        final List<AnimalA> animals =
            snapshot.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          {
            name = data['name'];
            animal = data['animal'];
            type = data['type'];
            gender = data['gender'];
            age = data['age'];
          }
          return AnimalA(
            name,
            animal,
            type,
            gender,
            age,
          );
        }).toList();
        this.animals = animals;
        notifyListeners();
      });
      //　年齢昇順で抽出
    } else if (selected == '年齢：昇順') {
      final Stream<QuerySnapshot> childrenStream = FirebaseFirestore.instance
          .collection('animals')
          .orderBy('age', descending: false)
          .snapshots();
      childrenStream.listen((QuerySnapshot snapshot) {
        final List<AnimalA> animals =
            snapshot.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          {
            name = data['name'];
            animal = data['animal'];
            type = data['type'];
            gender = data['gender'];
            age = data['age'];
          }
          return AnimalA(
            name,
            animal,
            type,
            gender,
            age,
          );
        }).toList();
        this.animals = animals;
        notifyListeners();
      });
      //　年齢降順で抽出(デフォルト)
    } else {
      final Stream<QuerySnapshot> childrenStream = FirebaseFirestore.instance
          .collection('animals')
          .orderBy('age', descending: true)
          .snapshots();
      childrenStream.listen((QuerySnapshot snapshot) {
        final List<AnimalA> animals =
            snapshot.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          {
            name = data['name'];
            animal = data['animal'];
            type = data['type'];
            gender = data['gender'];
            age = data['age'];
          }
          return AnimalA(
            name,
            animal,
            type,
            gender,
            age,
          );
        }).toList();
        this.animals = animals;
        notifyListeners();
      });
      notifyListeners();
    }
    notifyListeners();
  }
}
