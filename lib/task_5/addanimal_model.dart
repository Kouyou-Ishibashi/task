import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class AddAnimalModel extends ChangeNotifier {
  //コントローラ変数定義
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final ageController = TextEditingController();

  //変数定義
  // 入力値格納変数定義
  late String name;
  late String type;
  late int age;
  late String animal = '犬';
  late String gender = 'オス';

  // 名前更新処理
  void setName(String textName) {
    name = textName;
    notifyListeners();
  }

  // 種別更新処理
  void setType(String textType) {
    type = textType;
    notifyListeners();
  }

  // 年齢更新処理
  void setAge(int textAge) {
    age = textAge;
    notifyListeners();
  }

  // 年齢更新処理
  void setAnimal(String selectAnimal) {
    animal = selectAnimal;
    notifyListeners();
  }

  void setGender(String selectGender) {
    gender = selectGender;
    notifyListeners();
  }

  //新規登録
  Future input() async {
    if (name != '' && type != '') {
      final doc = FirebaseFirestore.instance.collection('animals').doc();
      await doc.set({
        'name': name,
        'animal': animal,
        'type': type,
        'gender': gender,
        'age': age
      });
    }
  }
}
