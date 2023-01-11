import 'package:bl_dairy_app/view/blshop/CustomerShop.dart';
import 'package:bl_dairy_app/view/screens/attendance.dart';
import 'package:bl_dairy_app/view/screens/book_order.dart';
import 'package:bl_dairy_app/view/screens/production.dart';
import 'package:bl_dairy_app/view/screens/report.dart';
import 'package:bl_dairy_app/view/screens/dashboard.dart';
import 'package:flutter/cupertino.dart';

var pageIndex = [
  const Dashboard_Scren(),
  const ReportScreen(),
  AttendanceScreen(),
  const BookOrderScreen(),
  const ProductionScreen(),
];

var shopMainIndex = [
  CustomerShop(),
  Center(child: Text("My Orders"),),
  Center(child: Text("Profile"),),


  ];
