import 'package:flutter/material.dart';
import 'package:flutter_application_3/modules/archived_tasks/archived_tasks.dart';
import 'package:flutter_application_3/modules/done_tasks/done_tasks.dart';
import 'package:flutter_application_3/modules/new_tasks/new_tasks.dart';
import 'package:flutter_application_3/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Database? database;
  List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  //Change Bottom Tab index
  void changeTabIndex(int index) {
    currentIndex = index;
    emit(AppChangedTabState());
  }

  //open database
  void openAppDatabase() async {
    await openDatabase(
      'todo_app2.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
            .then((value) {
          print('Table Created');
        }).catchError((err) {
          print('Error Occured: $err');
        });
      },
      onOpen: (database) {
        print('DatabaseOpened');
        getDataFromDatabase(database);
      },
    ).then(
      (value) {
        database = value;
        emit(AppOpenDatabaseState());
      },
    );
  }

  //insert into database
  void insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction(
      (txn) async {
        txn
            .rawInsert(
                'INSERT INTO Tasks(title, date, time,status) VALUES("$title", "$date","$time","new")')
            .then((value) {
          print('$value inserted');
          emit(AppInsertToDatabaseState());
          // emit get data
          getDataFromDatabase(database);
        }).catchError((err) {
          print('Error Occured: $err');
        }).then((value) => null);
      },
    );
  }

  //Get from database
  void getDataFromDatabase(database) {
    tasks = [];
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDataFromDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archivedTasks.add(element);
          }
        },
      );
      emit(AppGetDataFromDatabaseState());
    });
  }

  //update data
  void updateDatainDatabase({required int id, required String status}) async {
    database!.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataFromDatabaseState());
    });
  }

  //delete data
  void deleteDatainDatabase({required int id}) async {
    database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataFromDatabaseState());
    });
  }
}
