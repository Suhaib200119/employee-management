import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:example_database/shared/cubit/AppCubit.dart';
import 'package:example_database/shared/cubit/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Retired_Epmloyees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        AppCubit appCubitObject=AppCubit.getObjectFromAppCubit(ctx);
        List<Map> retired_Employee=appCubitObject.retired_Employee;
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
                ],
              ),
            ),
            SizedBox(height: 10,),
            ConditionalBuilder(
              condition: appCubitObject.retired_Employee.length>0,
              builder: (ctxCondition){return ListView.builder(
                itemBuilder:(context,index){
                  return  Container(
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
                            retired_Employee[index]["id"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          radius: 15 ,
                          backgroundColor: Colors.blue,
                        ),
                        Text("${retired_Employee[index]["name"]}"),
                        Text("${retired_Employee[index]["age"]}"),
                        Text("${retired_Employee[index]["salary"]}"),
                        Text("${retired_Employee[index]["address"]}"),

                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount:retired_Employee.length,
              );},
              fallback: (ctxCondition){return Center(child: CircularProgressIndicator());},
            ),
          ],
        );
      },
    );
  }
}


