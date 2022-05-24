// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_application_3/shared/components/components.dart';
import 'package:flutter_application_3/shared/cubit/cubit.dart';
import 'package:flutter_application_3/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..openAppDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
          var width = double.infinity;
          return Scaffold(
            key: scaffoldKey,
            body: cubit.screens[cubit.currentIndex],
            appBar: AppBar(
              title: const Text('Todo App'),
              actions: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.showBottomSheet(
                      (context) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  // ignore: prefer_const_constructors
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Center(
                                      child: Text(
                                        'Add New Task',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ignore: prefer_const_constructors
                                  Container(
                                    width: width / 2.w,
                                    height: 1.h,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  appTextFormField(
                                    controller: titleController,
                                    inputType: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    iconData: Icons.text_fields,
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  appTextFormField(
                                    controller: dateController,
                                    inputType: TextInputType.datetime,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Date must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    iconData: Icons.date_range_outlined,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2030-12-31'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                        print(dateController.text);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  appTextFormField(
                                    controller: timeController,
                                    inputType: TextInputType.datetime,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Time must not be empty';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    iconData: Icons.watch_later_outlined,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print(timeController.text);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AppButton(
                                        label: 'Add',
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.insertIntoDatabase(
                                              title: titleController.text,
                                              date: dateController.text,
                                              time: timeController.text,
                                            );
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      elevation: 20,
                    );
                    titleController.text = '';
                    timeController.text = '';
                    dateController.text = '';
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                const BottomNavigationBarItem(
                  icon: const Icon(Icons.list_alt),
                  label: "Tasks",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.task_alt,
                  ),
                  label: "Done",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: "Archived",
                ),
              ],
              onTap: (index) {
                cubit.changeTabIndex(index);
//                print(index);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }
}
