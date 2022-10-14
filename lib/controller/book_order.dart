import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class BookOrderController {


  static Future<List<Order>?> fetchOrder() async {
    List<Order> all_orders = [];
    await FirebaseFirestore.instance.collection("BookOrder").orderBy("OrderDelivaryDate").get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((order) {
        all_orders.add(Order.fromSnap(order));
      });
    });
    return all_orders;
  }


  static addOrder(Order myOrder) async {
    await FirebaseFirestore.instance.collection("BookOrder").add(
        myOrder.toJson()).then((_) {
      print("DATA ADDED SUCCESSFULLY");
    });
  }


  static Future<List<String>> fetchItems(String query) async {
    print("CALLING");
    List<String> result_items = [];
    await FirebaseFirestore.instance.collection("ProductList").where("ProductName" , isGreaterThanOrEqualTo: query).get().then((
        querSnapshots) {
      querSnapshots.docs.forEach((item) {
        result_items.add(OrderItem.fromSnap(item).ProductName);
        print(OrderItem.fromSnap(item).ProductName);

      });
    });

    return result_items;
  }
}









class OrderModel{
  String OrderName;
  int Quantity;
  int Rate;
  int Amount;

  OrderModel({
    required this.Rate,
    required this.Quantity,
    required this.Amount,
    required this.OrderName,

  });




}