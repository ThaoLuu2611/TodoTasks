import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/utils/app_text_style.dart';
import 'package:to_do_tasks/utils/utils.dart';
import 'package:to_do_tasks/widgets/done_screen.dart';
import 'package:to_do_tasks/widgets/incomplete_screen.dart';
import 'package:to_do_tasks/widgets/all_taks_screen.dart';
import 'package:to_do_tasks/models/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedScreen = 0;
  String _title = "All to-do list";
  String deadLine = "Choose your deadline";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late TodoBloc _bloc;
  bool isInvalidated = false;

  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreen = index;
      Utils.selectedScreen = _selectedScreen;
      switch (index) {
        case 0:
          _title = 'All to-do talks';
          break;
        case 1:
          _title = 'Completed list';
          break;
        case 2:
          _title = 'Incompleted list';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bloc = TodoBloc();
    _widgetOptions = <Widget>[];
    _bloc.todoTextController.text = '';

    _widgetOptions.add(AllTasksScreen(bloc: _bloc));
    _widgetOptions.add(DoneScreen(bloc: _bloc));
    _widgetOptions.add(IncompleteScreen(bloc: _bloc));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.blue[100],
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
              child: Text(
            _title,
            style: const TextStyle(fontSize: 18),
          )),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedScreen),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[300],
          child: const Icon(Icons.add),
          onPressed: _showBottomSheet //(){}// => _showBottomSheet(context),
          ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'All task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task_rounded),
            label: 'Done ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined),
            label: 'Incompleted',
          ),
        ],
        currentIndex: _selectedScreen,
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        selectedItemColor: Colors.blue[800],
        backgroundColor: Colors.blue[50],
        onTap: _onItemTapped,
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: true,
      backgroundColor: Colors.blue[50],
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            //padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 20),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: Colors.grey[700],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ADD NEW TASK',
                      style: AppTextStyle.mediumTitle(),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _bloc.todoTextController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.task),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.0),
                      ),
                      label: Text('New task'),
                      hintText: 'Add your task here',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(
                          left: 20, top: 4, right: 20, bottom: 4),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey[400], elevation: 0)),
                    const SizedBox(
                      width: 30,
                    ),
                    OutlinedButton(
                      child: const Text('Add task'),
                      onPressed: _addNewTask,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey[700],
                          side: const BorderSide(width: 1.0, color: Colors.orange)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _addNewTask() {
    var newTodoTask =
        Todo(title: _bloc.todoTextController.text, isDone: false);
    _bloc.addNewTask(newTodoTask);
    _bloc.todoTextController.clear();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
