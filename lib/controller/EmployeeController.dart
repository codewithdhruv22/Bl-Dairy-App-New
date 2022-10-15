import 'package:bl_dairy_app/model/employeeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeController{

  static Future<List<EmployeeModel>?> fetchAllEmp() async {
    List<EmployeeModel> all_emp = [];
    await FirebaseFirestore.instance.collection("Employee").orderBy("DateAdded").get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((order) {
        all_emp.add(EmployeeModel.fromSnap(order));
      });
    });
    return all_emp;
  }





  static addNewEmp(EmployeeModel newEmp) async {
    await FirebaseFirestore.instance.collection("Employee").add(
        newEmp.toJson()).then((_) {
      print("NEW EMPLOYEE REGISTERED SUCCESSFULLY");
    });
  }




  static Future<List<String>> fetchSearchEmp(String query) async {
    print("CALLING");
    List<String> result_emp = [];
    await FirebaseFirestore.instance.collection("Employee").where("EmpName" , isGreaterThanOrEqualTo: query).get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((emp) {
        result_emp.add(EmployeeModel.fromSnap(emp).EmpName);


      });
    });

    return result_emp;
  }
}