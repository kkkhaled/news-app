import 'package:flutter/material.dart';
import 'package:train_project/shared/components/components.dart';
import 'package:train_project/shared/components/constants.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  _NewTasksScreenState createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => buildTasksItem(tasks[index]),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
        itemCount: tasks.length);
  }
}
