import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookOrderController{
static Future<List<Order>?> fetchOrder() async{

List<Order> all_orders = [];
  await FirebaseFirestore.instance.collection("BookOrder").get().then((querSnapshots){
    querSnapshots.docs.forEach((order) {
      all_orders.add(Order.fromSnap(order));
    });
  });
  return all_orders;
  
}



static addOrder(Order myOrder) async{
  await FirebaseFirestore.instance.collection("BookOrder").add(myOrder.toJson()).then((_){
    print("DATA ADDED SUCCESSFULLY");
  });
}
}