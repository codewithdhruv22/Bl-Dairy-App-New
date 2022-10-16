import 'package:bl_dairy_app/controller/EmployeeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/employeeModel.dart';

class AddNewEmp_Screen extends StatefulWidget {
  const AddNewEmp_Screen({Key? key}) : super(key: key);

  @override
  State<AddNewEmp_Screen> createState() => _AddNewEmp_ScreenState();
}

class _AddNewEmp_ScreenState extends State<AddNewEmp_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("ADD EMPLOYEEE SCREEN"),
          ElevatedButton(
              onPressed: () {
                EmployeeController.addNewEmp(EmployeeModel(
                    EmpAadhr: "454545454",
                    EmpAddr: "DEMO",
                    EmpMobNo: "5656565",
                    EmpName: "DEMO",
                    EmpPerHrRate: 34,
                    DateAdded: Timestamp.now()));
              },
              child: const Text("Add New Employeeee"))
        ],
      ),
    );
  }
}
