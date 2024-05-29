import 'package:flutter/cupertino.dart';
import 'package:todo_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_flutter/widgets/todo_item.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoLists = Todo.todolist();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todoLists;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: crGrey,
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
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child: Text('All ToDos', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),),
                      ),
                      for (Todo todoo in _foundTodo.reversed)
                        TodoItem(
                          todo: todoo,
                          onTodoChange: _handleTodoChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: crWhite,
                    boxShadow: const [BoxShadow(
                      color: crGrey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add new To Do',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20),
                  child: ElevatedButton(
                      onPressed: (){
                        _addTodoItem(_todoController.text);
                      },
                      child: Text('+', style: TextStyle(fontSize: 40),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: crBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),

                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  void _handleTodoChange(Todo todoo){
    setState(() {
      todoo.isDone = !todoo.isDone;
    });
  }

  void _deleteTodoItem(String id){
    setState(() {
      todoLists.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todoo){
    setState(() {
      todoLists.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todoo
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String keyword){
    List<Todo> results = [];
    if (keyword.isEmpty){
      results = todoLists;
    } else {
      results = todoLists
          .where((item)=>item.todoText!
            .toLowerCase()
            .contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });

  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: crWhite,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: crBlack,
              size: 20,),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: crGrey)
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: crGrey,
      elevation: 0,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          Icon(Icons.menu, color: crBlack,size: 30,),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/pic.jpg'),),
          )
      ]),

    );
  }
}
