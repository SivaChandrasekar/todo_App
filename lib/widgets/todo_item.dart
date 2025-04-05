import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';
import 'package:todoapp/modals/todo_modal.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo,required this.onTodoChanged,required this.onDeleteItem});

  final ToDo todo;
  final onTodoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            onTap: onTodoChanged(todo),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            tileColor: Colors.white,
            leading: Icon( todo.isDone ? Icons.check_box: Icons.check_box_outline_blank, color: tdBlue),
            title: Text(
              todo.todoText!,
              style: TextStyle(
                fontSize: 18,
                color: tdBlack,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(color:Colors.white,iconSize: 20,onPressed: onDeleteItem(todo.id), icon: Icon(Icons.delete)),
            ),
          ),
        );
  }
}
