import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:example_database/shared/cubit/AppCubit.dart';
import 'package:example_database/shared/cubit/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Employees_working extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        AppCubit appCubitObject=AppCubit.getObjectFromAppCubit(ctx);
        List<Map> work_Employee=appCubitObject.work_Employee;
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0,
              ),
              width: double.infinity,
              height: 50,
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("ID"),
                  Text("NAME"),
                  Text("AGE"),
                  Text("SAL"),
                  Text("ADD"),
                  Text("retirement")
                ],
              ),
            ),
            SizedBox(height: 10,),
            ConditionalBuilder(
              condition: appCubitObject.work_Employee.length>0,
              builder: (ctxCondition){return ListView.builder(
                itemBuilder:(context,index){
                  return Dismissible(
                    key: Key("${work_Employee[index]["id"]}"),
                    onDismissed: (Direction){
                      appCubitObject.deleteData(work_Employee[index]["id"]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 0,
                      ),
                      width: double.infinity,
                      height: 50,
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            child: Text(
                              work_Employee[index]["id"].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            radius: 15 ,
                            backgroundColor: Colors.blue,
                          ),
                          Text("${work_Employee[index]["name"]}"),
                          Text("${work_Employee[index]["age"]}"),
                          Text("${work_Employee[index]["salary"]}"),
                          Text("${work_Employee[index]["address"]}"),
                          InkWell(
                            child: Text("retirement"),
                            onTap: (){
                              appCubitObject.updateData(work_Employee[index]["id"]);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount:work_Employee.length,
              );},
              fallback: (ctxCondition){return Center(child: CircularProgressIndicator());},
            ),
          ],
        );
      },
    );
  }
}


