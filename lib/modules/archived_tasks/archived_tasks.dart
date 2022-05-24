import 'package:flutter/material.dart';
import 'package:flutter_application_3/shared/components/components.dart';
import 'package:flutter_application_3/shared/cubit/cubit.dart';
import 'package:flutter_application_3/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_open,
                  size: 100,
                ),
                Text(
                  'There is no archived tasks, please add new tasks',
                  style: TextStyle(
                    fontSize: 16,
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
    ;
  }
}
