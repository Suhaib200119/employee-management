import 'package:bloc/bloc.dart';
import 'package:example_database/module/add_employee/AddEmployee.dart';
import 'package:example_database/module/employees_working/Employees_Working.dart';
import 'package:example_database/module/retired_employees/Retired_employees.dart';
import 'package:example_database/shared/cubit/AppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit getObjectFromAppCubit(context) {
    return BlocProvider.of(context);
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.add), label: "Add Employee"),
    BottomNavigationBarItem(
        icon: Icon(Icons.slideshow), label: "employees working"),
    BottomNavigationBarItem(
        icon: Icon(Icons.assignment_return), label: "retired employees"),
  ];
  List<Widget> screens = [
    new AddEmployee(),
    new Employees_working(),
    new Retired_Epmloyees()
  ];
  int currentIndex = 0;
  void changeCurrentIndex(int indexItem) {
    currentIndex = indexItem;
    emit(ChangeCurrentIndexOfTheBottomNavigationBarItemState());
  }



  List<Map> work_Employee = [];
  List<Map> retired_Employee = [];

  late Database database;

  void createDatabase() {
    openDatabase("company", version: 1,
        onCreate: (Database datbaseObject, int version) async {
      print("Database Company Created");
      await datbaseObject
          .execute("CREATE TABLE employee "
              "(id INTEGER PRIMARY KEY , name TEXT , age INTEGER , salary REAL , address TEXT , date TEXT, status TEXT)")
          .then((value) {
        print("Table Employee Created");
      }).catchError((error) {
        print("Error When Create Database Or Table");
      });
    }, onOpen: (Database databaseObject)  {
      print("Database Company Opend");
      getDataFromDataBase(databaseObject);
    }).then((value) {
      database = value;
      emit(CreateDatabase());
    });
  }

  void insertToDatabase({
    required String name,
    required int age,
    required double salary,
    required String address,
    required String date,
    required String status
  }) {
     database.transaction((txn) async {
      await txn.rawInsert(
              'INSERT INTO EMPLOYEE (name,age,salary,address,date,status) '
                  'VALUES("$name",$age,$salary,"$address","$date","$status")'
      ).then((value) {
        emit(InsertDataToDatabaseState());
        getDataFromDataBase(database);
      }).catchError((Errror) {
        print("Error When insert : ${Errror.toString()}");
      });
    });
  }

  void getDataFromDataBase(Database databaseObject) async {
    work_Employee.clear();
    retired_Employee.clear();
     databaseObject.rawQuery("SELECT * FROM employee").then((value){
       value.forEach((element) {
         if(element["status"]=="works"){
           work_Employee.add(element);
         }else{
           retired_Employee.add(element);
         }
       });
       emit(GetDataFromDatabaseState());
     });
  }

  void deleteData(int id)async{
        database.rawDelete("DELETE FROM employee WHERE id = ?",[id]).then((value) {
          getDataFromDataBase(database);
        });
  }


  void updateData(int id)async{
    database.rawUpdate(
    'UPDATE employee SET status = ?  WHERE id = ?',
    ["retired", id]).then((value) {
      getDataFromDataBase(database);
    });
  }

}
