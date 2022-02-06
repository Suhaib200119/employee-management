// import 'package:sqflite/sqflite.dart';
// late Database database;
//
// void createDatabase()async{
//   database =await openDatabase(
//       "company",
//       version: 1,
//       onCreate: (Database datbaseObject,int version)async{
//         print("Database Company Created");
//         await datbaseObject.execute("CREATE TABLE employee "
//             "(id INTEGER PRIMARY KEY , name TEXT , age INTEGER , salary REAL , address TEXT , date TEXT)").then((value) {
//           print("Table Employee Created");
//         }).catchError((error){
//           print("Error When Create Database Or Table");
//         });
//       },
//       onOpen: (Database databaseObject)async{
//         print("Database Company Opend");
//       }
//   );
// }
//
// Future InsertToDatabase({
//   required String name,
//   required int age,
//   required double salary,
//   required String address,
//   required String date,
// }){
//   return database.transaction((txn)async{
//     await txn.rawInsert(
//         'INSERT INTO EMPLOYEE (name,age,salary,address,date) VALUES("$name",$age,$salary,"$address","$date")'
//     ).then((value){
//       print("the insertion done : $value");
//     }).catchError((Errror){
//       print("Error When insert : ${Errror.toString()}");
//     });
//   });
// }
//
// Future<List<Map>> getDataFromDataBase(Database databaseObject,String query)async{
//   List<Map> dataEmployee_initail=await databaseObject.rawQuery(query);
//    return dataEmployee_initail;
//
// }