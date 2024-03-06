import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todoItem.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  final todoText = TextEditingController();
  List<ToDo> filterTask = [];

  @override
  void initState() {
    filterTask = todoList;
    super.initState();
  }

  void handleChangeToDo(ToDo item) {
    setState(() {
      item.isDone = !item.isDone!;
    });
  }

  void handleDeleteTask(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void handleFilterTask(String task) {
    List<ToDo> result = [];
    if (task.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((element) => element.text!.toLowerCase().contains(task))
          .toList();
    }

    setState(() {
      filterTask = result;
    });
  }

  void handleAddTask(String task) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: task));
    });
    todoText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            'All ToDos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        for (ToDo item in filterTask.reversed)
                          ToDoItem(
                            todo: item,
                            onToDoChanged: handleChangeToDo,
                            onDeleteItem: handleDeleteTask,
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 78, 64, 64),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: todoText,
                        decoration: InputDecoration(
                            hintText: "Add to do list of your day",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        handleAddTask(todoText.text);
                      },
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 27, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        fixedSize: Size(60, 60),
                        backgroundColor: blueColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: bgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu, color: blackColor, size: 30),
            CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.jpeg'))
          ],
        ));
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => handleFilterTask(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: blackColor, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
            border: InputBorder.none,
            hintText: "Search...",
            hintStyle: TextStyle(color: greyColor)),
      ),
    );
  }
}
