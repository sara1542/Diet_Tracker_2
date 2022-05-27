import 'package:bloc/bloc.dart';
import 'package:firstgp/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

   int currentIndex = 0;
   late Database database;
  List<Map> NewTasks=[];
  List<Map> DoneTasks=[];
  List<Map> ArchivedTasks=[];

  //  List<Widget> screens = [
  //   NewTasksScreen(),
  //   DoneTasksScreen(),
  //   ArchivedTasksScreen()
  // ];
   List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index){
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase()  {
    openDatabase('todo.db', version: 1,
        onCreate: (db, version) async {
          print('Database created');
          await db
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .then((value) {
            print('Table created');
          }).catchError((error) {
            print(error);
          });
        }, onOpen: (db) {

          getDataFromDatabase(db);
          print('Database opened');
        }).then((value) {
          database=value;
          emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
     await database.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title" ,"$date" ,"$time" ,"new")')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {});


    });
  }

  void getDataFromDatabase(db){
    NewTasks=[];
    DoneTasks=[];
    ArchivedTasks=[];
    db.rawQuery('SELECT * FROM tasks').then((value) {
        print(value);
      value.forEach((element){
        if (element['status']=='new'){
          NewTasks.add(element);
        }
        else if (element['status']=='done'){
          DoneTasks.add(element);
        }
        else
          {
            ArchivedTasks.add(element);
          }
      });
      emit(AppGetDatabaseState());
    }
    );
  }

  void updateDatabase({
  required String status,
    required int id
})async{
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]).then((value) {
       getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
     });

  }
  void deleteDatabase({
    required int id
  })async{
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [ id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }


  bool isBottomSheetShown = false;

  void changeBottomSheetState({
  required bool isShow
}){
    isBottomSheetShown=isShow;
    emit(AppChangeBottomSheetState());
  }

}