class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todolist(){
    return [
      Todo(id: '01', todoText: 'Go Running', isDone: true),
      Todo(id: '02', todoText: 'Go Campus', isDone: true),
      Todo(id: '03', todoText: 'Clear TA'),
      Todo(id: '04', todoText: 'Learn Flutter'),
      Todo(id: '05', todoText: 'Do work'),
      Todo(id: '06', todoText: 'Synrgy clear', isDone: true),
    ];
  }



}