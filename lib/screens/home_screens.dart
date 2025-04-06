import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/modals/todo_modal.dart';
import 'package:todoapp/widgets/todo_item.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundTodoList = [];

  @override
  void initState() {
    _foundTodoList = todoList;
    super.initState();
  }

  void _handleTodoChanges(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todo) {
    if (todo.isNotEmpty) {
    setState(() {
      todoList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ),
      );
    });
    }else {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Required'),
          content: Text('Could you please add some values?'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }
    _todoController.clear();
  }

  void _searchingTodo(String enteredText) {
    List<ToDo> results = [];
    if (enteredText.isEmpty) {
      results = todoList;
    } else {
      results =
          todoList
              .where(
                (item) => item.todoText!.toLowerCase().contains(
                  enteredText.toLowerCase(),
                )
              )
              .toList();
    }
    setState(() {
      _foundTodoList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          style: TextStyle(
                            color: tdBlack,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                          "TODOs",
                        ),
                      ),
                      for (ToDo todoo in _foundTodoList.reversed)
                        TodoItem(
                          todo: todoo,
                          onTodoChanged: _handleTodoChanges,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          addTodoBox(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _searchingTodo(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdGrey, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  Widget addTodoBox() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo item',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                _addTodoItem(_todoController.text);
              },
              child: Text('+', style: TextStyle(fontSize: 40)),
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                foregroundColor: Colors.white,
                minimumSize: Size(60, 60),
                elevation: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
