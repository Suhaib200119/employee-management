import 'package:example_database/shared/cubit/AppCubit.dart';
import 'package:example_database/shared/cubit/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return AppCubit()..createDatabase();
        },
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (ctx,state){},
        builder: (ctx,state){
          AppCubit appCubitObject=AppCubit.getObjectFromAppCubit(ctx);
          String titleBar=appCubitObject.bottomNavigationBarItems[appCubitObject.currentIndex].label.toString();
          return Scaffold(
            appBar: AppBar(
              title: Text("$titleBar"),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: appCubitObject.bottomNavigationBarItems,
              currentIndex: appCubitObject.currentIndex,
              onTap: (int indexItem){
                appCubitObject.changeCurrentIndex(indexItem);
              },
            ),
            body:appCubitObject.screens[appCubitObject.currentIndex],
          );
        },
      ),
    );
  }


}

