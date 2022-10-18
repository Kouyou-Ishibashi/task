// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'addanimal_model.dart';
import 'animallist.dart';

class AddAnimal extends StatefulWidget {
  const AddAnimal({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddAnimal createState() => _AddAnimal();
}

// ラジオボタン定義
enum Gender { male, female }

enum Animal { dog, cat }

class _AddAnimal extends State<AddAnimal> {
  Gender _gender = Gender.male;
  Animal _animal = Animal.dog;

  // 動物選択処理
  void setAnimal(value) {
    setState(() {
      _animal = value;
    });
  }

  // 性別選択処理
  void setGender(value) {
    setState(() {
      _gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddAnimalModel>(
        create: (_) => AddAnimalModel(),
        child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(child: Center(
              child: Consumer<AddAnimalModel>(builder: (context, model, child) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                        controller: model.nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '名前',
                        ),
                        onChanged: (text) {
                          model.setName(text);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: Animal.dog,
                              groupValue: _animal,
                              onChanged: (value) {
                                setAnimal(value);
                                model.setAnimal('犬');
                              },
                            ),
                            const Text('犬')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Animal.cat,
                              groupValue: _animal,
                              onChanged: (value) {
                                setAnimal(value);
                                model.setAnimal('猫');
                              },
                            ),
                            const Text('猫')
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                        controller: model.typeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '品種',
                        ),
                        onChanged: (text) {
                          model.setType(text);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: Gender.male,
                              groupValue: _gender,
                              onChanged: (value) {
                                setGender(value);
                                model.setGender('オス');
                              },
                            ),
                            const Text('オス')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: Gender.female,
                              groupValue: _gender,
                              onChanged: (value) {
                                setGender(value);
                                model.setGender('メス');
                              },
                            ),
                            const Text('メス')
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: TextField(
                        controller: model.ageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: '年齢',
                        ),
                        onChanged: (text) {
                          model.setAge(int.parse(text));
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await model.input();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AnimalListPage(),
                              ));
                        },
                        child: const Text('登録する'))
                  ],
                );
              }),
            ))));
  }
}
