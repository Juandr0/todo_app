import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/services/firebase_handler.dart';
import 'package:todo_app/widgets/alert_builder.dart';
import 'package:todo_app/widgets/todo_item.dart';

import '../constants/app_sizes.dart';
import '../models/to_do.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [];
  bool isSearchVisible = false;
  final TextEditingController searchController = TextEditingController();
  final _firebaseHandler = FirebaseHandler();

  @override
  void initState() {
    super.initState();
    _firebaseHandler.signInAnonymously();
    _firebaseHandler.setupTodoListener();
  }

  @override
  void dispose() {
    super.dispose();
    _firebaseHandler.disposeListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: const Row(children: [
          Icon(Icons.menu, color: AppColors.darkGrey, size: AppSizes.inline * 5)
        ]),
        actions: [
          Visibility(
            visible: !isSearchVisible,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isSearchVisible = !isSearchVisible;
                });
              },
              icon: const Icon(Icons.search),
              color: AppColors.darkGrey,
            ),
          ),
        ],
        flexibleSpace: Visibility(
          visible: isSearchVisible,
          child: Container(
            width: double.infinity,
            height: AppSizes.between * 2,
            margin: const EdgeInsets.only(
              top: AppSizes.inline * 11,
              bottom: AppSizes.between / 2,
              left: AppSizes.inline * 11,
              right: AppSizes.between * 2,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.inline),
            ),
            child: Center(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        if (searchController.text.isEmpty) {
                          isSearchVisible = false;
                        }
                        searchController.clear();
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _firebaseHandler.todoStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          todos = snapshot.data ?? [];

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.inline * 3,
              vertical: AppSizes.inline * 3,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: AppSizes.between * 2,
                          bottom: AppSizes.between,
                        ),
                      ),
                      for (int index = 0; index < todos.length; index++)
                        ToDoItem(
                          todo: todos[index],
                          onTodoChanged: (updatedTodo) =>
                              handleTodoChange(updatedTodo, index),
                        ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo newTodo = Todo.createTodo();
          AlertBuilder.buildPostIt(context, newTodo, (handleTodoChange) {
            setState(() {
              if (newTodo.title != '') {
                _firebaseHandler.saveTodo(newTodo);
              }
            });
          });
        },
        backgroundColor: AppColors.darkGrey,
        child: const Icon(Icons.add),
      ),
    );
  }

  void handleTodoChange(Todo updatedTodo, int index) {
    setState(() {
      todos[index] = updatedTodo;
      _firebaseHandler.saveTodo(updatedTodo);
    });
  }
}
