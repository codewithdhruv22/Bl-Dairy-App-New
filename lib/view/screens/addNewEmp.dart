import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/controller/EmployeeController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/employeeModel.dart';

class AddNewEmp_Screen extends StatefulWidget {
  const AddNewEmp_Screen({Key? key}) : super(key: key);

  @override
  State<AddNewEmp_Screen> createState() => _AddNewEmp_ScreenState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController empname = TextEditingController();
TextEditingController emphnum = TextEditingController();
TextEditingController emaddre = TextEditingController();
TextEditingController emadhrnum = TextEditingController();
TextEditingController empprhourrate = TextEditingController();

class _AddNewEmp_ScreenState extends State<AddNewEmp_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Employe"),
        backgroundColor: MyColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill Name';
                  }
                  return null;
                },
                controller: empname,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill Number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: emphnum,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill Address';
                  }
                  return null;
                },
                controller: empname,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill Number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: empname,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Adhaar Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fill Value';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: empname,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Stipend/Hr',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      EmployeeController.addNewEmp(EmployeeModel(
                          EmpAadhr: "454545454",
                          EmpAddr: "DEMO",
                          EmpMobNo: "5656565",
                          EmpName: "DEMO",
                          EmpPerHrRate: 34,
                          DateAdded: Timestamp.now()));
                    }
                  },
                  child: const Text("Add New Employeeee"))
            ],
          ),
        ),
      ),
    );
  }
}
