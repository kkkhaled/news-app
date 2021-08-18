import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:train_project/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:train_project/modules/done_tasks/done_tasks_screen.dart';
import 'package:train_project/modules/new_tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:train_project/shared/components/components.dart';
import 'package:train_project/shared/components/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  int currentIndex = 0;
  Database? database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      body: ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context) => screens[currentIndex],
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDataBase(
                      title: titleController.text,
                      date: dateController.text,
                      time: timeController.text)
                  .then((value) {
                Navigator.pop(context);
                getDataFromDataBase(database).then((value) {
                  setState(() {
                    tasks = value;
                    fabIcon = Icons.edit;
                    isBottomSheetShown = false;
                  });

                  print(tasks);
                });
              });
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet(
                    (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title),
                                SizedBox(height: 15.0),
                                defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print('time :' +
                                            ' ' +
                                            value.format(context));
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined),
                                SizedBox(height: 15.0),
                                defaultFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2021-10-22'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMMd().format(value!);
                                      });
                                    },
                                    validate: (value) {
                                      if (value.isEmpty) {
                                        return 'date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefix: Icons.calendar_today)
                              ],
                            ),
                          ),
                        ),
                    elevation: 20.0)
                .closed
                .then((value) {
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });

            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archived'),
        ],
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('db created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print("Error On Creating Table ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database).then((value) {
          setState(() {
            tasks = value;
          });
          print(tasks);
        });
        print('db openned');
      },
    );
  }

  Future insertToDataBase(
      {@required String? title,
      @required String? time,
      @required String? date}) async {
    await database?.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');
      }).catchError((error) {
        print("Error On Inserting New Record ${error.toString()}");
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDataBase(database) async {
    return await database!.rawQuery('select * from tasks');
  }
}
