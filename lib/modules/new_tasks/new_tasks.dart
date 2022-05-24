import 'package:flutter/material.dart';
import 'package:flutter_application_3/shared/components/components.dart';
import 'package:flutter_application_3/shared/cubit/cubit.dart';
import 'package:flutter_application_3/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        if (tasks.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_open,
                  size: 100,
                ),
                Text(
                  'There is no new tasks, please add new tasks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}
