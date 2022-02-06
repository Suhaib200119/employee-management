import 'package:example_database/shared/cubit/AppCubit.dart';
import 'package:example_database/shared/cubit/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var formKey=GlobalKey<FormState>();
  TextEditingController tec_name=new TextEditingController();
  TextEditingController tec_age=new TextEditingController();
  TextEditingController tec_salary=new TextEditingController();
  TextEditingController tec_address=new TextEditingController();
  TextEditingController tec_date=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (ctx,state){},
      builder: (ctx,state){
        AppCubit appCubitObject=AppCubit.getObjectFromAppCubit(ctx);
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.fromSTEB(15, 20, 10, 0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller:tec_name,
                    validator:(valueUser){
                      if(valueUser.toString().isEmpty){
                        return "you must enter the name";
                      }
                    } ,
                    keyboardType:TextInputType.name ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your name"),
                      prefixIcon: (Icon(Icons.person_sharp)),
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller:tec_age ,
                    validator: (valueUser){
                      if(valueUser.toString().isEmpty){
                        return "you must enter the age";
                      }
                    },
                    keyboardType:TextInputType.number ,
                    decoration:InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your age"),
                      prefixIcon: Icon(Icons.ac_unit),
                    ) ,
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller:tec_salary,
                    validator:(valueUser){
                      if(valueUser.toString().isEmpty){
                        return "you must enter the salary";
                      }
                    } ,
                    keyboardType:TextInputType.number ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your salary"),
                      prefixIcon: (Icon(Icons.monetization_on_outlined)),
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller:tec_address ,
                    validator: (valueUser){
                      if(valueUser.toString().isEmpty){
                        return "you must enter the addres";
                      }
                    },
                    keyboardType:TextInputType.text ,
                    decoration:InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your address"),
                      prefixIcon: Icon(Icons.location_on),
                    ) ,
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller:tec_date,
                    validator:(valueUser){
                      if(valueUser.toString().isEmpty){
                        return "you must enter the date";
                      }
                    } ,
                    keyboardType:TextInputType.datetime ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your date"),
                      prefixIcon: (Icon(Icons.date_range)),
                    ),
                    onTap: (){
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1965,1,1),
                          lastDate: DateTime.now()
                      ).then((value){
                        tec_date.text=value.toString().substring(0,10);
                      });
                    },
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          appCubitObject.insertToDatabase(
                            name: tec_name.text,
                            age: int.parse(tec_age.text),
                            salary: double.parse(tec_salary.text),
                            address: tec_address.text,
                            date: tec_date.text,
                            status: "works",
                          );
                        }
                      },
                      child: Text(
                        "Add Employee",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
