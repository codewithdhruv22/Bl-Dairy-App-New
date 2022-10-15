import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel{
  // Name
  // Mb No
  // Address
  // Addhar No
  // PerHr/Rate
  String EmpName;
  String EmpMobNo;
  String EmpAddr;
  String EmpAadhr;
  int EmpPerHrRate;
  Timestamp DateAdded;

  EmployeeModel({
    required this.EmpAadhr,
    required this.EmpAddr,
    required this.EmpMobNo,
    required this.EmpName,
    required this.EmpPerHrRate,
    required this.DateAdded
});

  Map<String , dynamic> toJson()=> {
    "EmpAadhr" : EmpAadhr,
    "EmpAddr" : EmpAddr,
    "EmpMobNo" : EmpMobNo,
    "EmpName" : EmpName,
    "EmpPerHrRat" : EmpPerHrRate,
    "DateAdded" : Timestamp.now()
  };







  static EmployeeModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return EmployeeModel(
      EmpAadhr : snapshot["EmpAadhr"] ?? "NO DATA",
      EmpAddr : snapshot["EmpAddr"] ?? "NO DATA",
      EmpMobNo : snapshot["EmpMobNo"] ?? "NO DATA",
      EmpName : snapshot["EmpName"] ?? "NO DATA",
      EmpPerHrRate : snapshot["EmpPerHrRate"] ?? "NO DATA",
      DateAdded : snapshot["DateAdded"] ?? "NO DATA",




    );
  }



}