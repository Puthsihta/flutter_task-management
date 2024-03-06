import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: blueColor,
        ),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(
          todo.text!,
          style: TextStyle(
              fontSize: 16,
              color: blackColor,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18,
          ),
        ),
      ),
    );
  }
}
