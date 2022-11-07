import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task/task_6/todo.dart';
import 'package:flutter_task/task_6/todolistmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: non_constant_identifier_names
final TodoListProvider =
    ChangeNotifierProvider.autoDispose((ref) => TodoListModel());

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // riverpod設定
      home: const ProviderScope(
        child: TodoList(),
      ),
    );
  }
}

// ignore: must_be_immutable
class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListProvider = ref.watch(TodoListProvider);
    final List<Todo>? todoLists = todoListProvider.fetchTodos();
    final int editButtonStatus = todoListProvider.editButtonStatus;

    if (todoLists == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Todoリスト'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () {
                  todoListProvider.editButtonStatusOn();
                },
                icon: const Icon(Icons.edit))
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Todoリスト'),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () {
                  todoListProvider.editButtonStatusOn();
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: ReorderableListView.builder(
          itemCount: todoLists.length,
          itemBuilder: (context, index) {
            final todo = todoLists[index];

            return
                /* 編集ページ */
                // 一覧ページでも編集ページでも既に実施ずみのTodoは横線を引いて表示
                // 編集ページではTodoリストをタップするとダイアログが表示されて編集が可能
                // Todoリストの右側にレッドのクリアボタンを設置し、タップすると削除可能
                editButtonStatus == 1
                    ? ListTile(
                        key: ValueKey(todo),
                        title: InkWell(
                            child: Text(
                              todo.content,
                              style: todo.judge == 0
                                  ? null
                                  : const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                            ),
                            onTap: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (_) {
                                    return ProviderScope(
                                        child: EditAlertDialog(
                                      content: todo.content,
                                      id: todo.id,
                                    ));
                                  });
                            }),
                        trailing: IconButton(
                          onPressed: () {
                            todoListProvider.deleteTodo(todo.id);
                          },
                          icon: const Icon(Icons.clear),
                          color: Colors.red,
                        ))

                    /* Todo一覧ページ */
                    // 未実施のタスクはタスク内容のみ表示
                    // 実施済のタスクは①文字に横線②文字色がグレー③右側にグリーンのcheckマーク表示
                    : ListTile(
                        key: ValueKey(todo),
                        title: InkWell(
                            child: Text(
                              todo.content,
                              style: todo.judge == 0
                                  ? null
                                  : const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                            ),
                            onTap: () {
                              ref
                                  .watch(TodoListProvider)
                                  .updateTodoStatusComplete(
                                      todo.id, todo.judge);
                            }),
                        trailing: todo.judge == 0
                            ? null
                            : IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.check),
                                color: Colors.green,
                              ));
          },
          onReorder: (int oldIndex, int newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            todoLists.insert(newIndex, todoLists.removeAt(oldIndex));
          },
          header: editButtonStatus == 1 && todoLists.isNotEmpty
              ? ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog<void>(
                          context: context,
                          builder: (_) {
                            return const ProviderScope(child: AddAlertDialog());
                          });
                    },
                    icon: const Icon(Icons.add),
                  ),
                  title: const Text('タスクを追加'),
                )
              : null,
          footer: editButtonStatus == 1
              ? ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog<void>(
                          context: context,
                          builder: (_) {
                            return const ProviderScope(child: AddAlertDialog());
                          });
                    },
                    icon: const Icon(Icons.add),
                  ),
                  title: const Text('タスクを追加'),
                )
              : null,
        ));
  }
}

// ダイアログ(追加用)
class AddAlertDialog extends ConsumerWidget {
  const AddAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoListProvider = ref.watch(TodoListProvider);
    late TextEditingController addTextController =
        todoListProvider.addTextController;

    return AlertDialog(
      title: const Text('タスクを追加'),
      content: TextField(
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
        ),
        controller: addTextController,
        onChanged: (text) {
          todoListProvider.addTexts(text);
        },
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: const Text(
                'キャンセル',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                todoListProvider.addTodo();
                Navigator.pop(context);
              },
            )
          ],
        )
      ],
    );
  }
}

// ダイアログ(編集用)
// ignore: must_be_immutable
class EditAlertDialog extends ConsumerWidget {
  late String content;
  late String id;

  EditAlertDialog({Key? key, required this.content, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoListProvider = ref.watch(TodoListProvider);
    late TextEditingController editTextController =
        todoListProvider.editTextController;
    todoListProvider.beforeText = content;

    return AlertDialog(
      title: const Text('タスクを編集'),
      content: TextField(
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
        ),
        controller: editTextController,
        onChanged: (text) {
          todoListProvider.editTexts(text);
        },
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: const Text(
                'キャンセル',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                todoListProvider.updateTodo(id);
                Navigator.pop(context);
              },
            )
          ],
        )
      ],
    );
  }
}
