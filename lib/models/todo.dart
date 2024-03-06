class ToDo {
  String? id;
  String? text;
  bool? isDone;

  ToDo({required this.id, required this.text, this.isDone = false});

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        text: 'Task 1',
        isDone: true,
      ),
      ToDo(
        id: '2',
        text: 'Task 2',
      ),
      ToDo(
        id: '3',
        text: 'Task 3',
        isDone: true,
      ),
    ];
  }
}
