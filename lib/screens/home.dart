import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/services/firebase_handler.dart';
import 'package:todo_app/themes/theme_handler.dart';
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
  bool isDropdownVisible = false;
  BackgroundTheme activeTheme = BackgroundTheme.disabled;
  final TextEditingController searchController = TextEditingController();
  final _firebaseHandler = FirebaseHandler();
  int popMenuIndex = 4;

  @override
  void initState() {
    super.initState();
    _firebaseHandler.signInAndSetup();
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
      appBar: _buildAppBar(),
      body: Stack(children: [
        ThemeHandler(theme: activeTheme),
        StreamBuilder<List<Todo>>(
          stream: _firebaseHandler.todoStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            todos = snapshot.data ?? [];
            List<Todo> filteredTodos = todos
                .where((todo) => todo.title.toLowerCase().contains(
                      searchController.text.toLowerCase(),
                    ))
                .toList();

            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.inline * 3,
                vertical: AppSizes.inline * 3,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(filteredTodos[index].documentId ?? ''),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: AppSizes.inline),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            _firebaseHandler.deleteTodo(filteredTodos[index]);
                          },
                          child: ToDoItem(
                            todo: filteredTodos[index],
                            onTodoChanged: (updatedTodo) =>
                                handleTodoChange(updatedTodo, index),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
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

  AppBar _buildAppBar() {
    var appBarHeight = AppBar().preferredSize.height;
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      leading: PopupMenuButton(
        initialValue: popMenuIndex,
        onSelected: (value) {
          _onMenuItemClicked(value as int);
        },
        itemBuilder: (ctx) => [
          _buildPopupMenuItem(
              "Blue bubbles", "assets/themes/bluebubbles.png", 0),
          _buildPopupMenuItem(
              "Oranges bubbles", "assets/themes/orangebubbles.png", 1),
          _buildPopupMenuItem("Particles", "assets/themes/particles.png", 2),
          _buildPopupMenuItem("Space", "assets/themes/space.png", 3),
          _buildPopupMenuItem("No theme", null, 4),
        ],
        offset: Offset(0, appBarHeight + AppSizes.within),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.inline)),
        ),
        icon: const Icon(Icons.menu,
            color: AppColors.darkGrey, size: AppSizes.inline * 5),
      ),
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
              onChanged: (value) {
                setState(() {
                  // Triggers a rebuild when input changes
                });
              },
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
    );
  }

  _onMenuItemClicked(int value) {
    setState(() {
      switch (value) {
        case 0:
          activeTheme = BackgroundTheme.blueBubbles;
          popMenuIndex = 0;
          break;
        case 1:
          activeTheme = BackgroundTheme.orangeBubbles;
          popMenuIndex = 1;
          break;
        case 2:
          activeTheme = BackgroundTheme.particles;
          popMenuIndex = 2;
          break;
        case 3:
          activeTheme = BackgroundTheme.space;
          popMenuIndex = 3;
          break;
        case 4:
          activeTheme = BackgroundTheme.disabled;
          popMenuIndex = 4;
          break;
        default:
          activeTheme = BackgroundTheme.disabled;
          popMenuIndex = 5;
          break;
      }
    });
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, String? imageString, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          imageString == null
              ? const Icon(
                  Icons.do_disturb_alt_outlined,
                  color: Colors.red,
                )
              : Image.asset(
                  imageString,
                  width: AppSizes.between,
                  height: AppSizes.between,
                ),
          const SizedBox(width: AppSizes.within),
          Text(title),
        ],
      ),
    );
  }
}
