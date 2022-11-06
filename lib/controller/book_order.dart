import 'package:bl_dairy_app/model/BookOrderModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookOrderController {
  static Future<List<Order>?> fetchOrder() async {
    List<Order> all_orders = [];
    await FirebaseFirestore.instance
        .collection("NewBookOrder")
        .orderBy("OrderDelivaryDate")
        .get()
        .then((querSnapshots) {
      querSnapshots.docs.forEach((order) {
        print("I AM ORDER !!!");
        print(order.data());
        all_orders.add(Order.fromSnap(order));
      });
    });
    return all_orders;
  }

  static addOrder(Order myOrder) async {
    await FirebaseFirestore.instance
        .collection("NewBookOrder")
        .add(myOrder.toJson())
        .then((_) {
      print("DATA ADDED SUCCESSFULLY");
    });
  }

  static Future<List<String>> fetchItems() async {
    print("CALLING");
    List<String> result_items = [];
    await FirebaseFirestore.instance
        .collection("ProductList")
        .get()
        .then((querSnapshots) {
      querSnapshots.docs.forEach((item) {
        result_items.add(ProductList.fromSnap(item).ProductName);
        print(ProductList.fromSnap(item).ProductName);
      });
    });

    return result_items;
  }

  static ChangeProductionStatus(String? orderId, bool status) async {
    await FirebaseFirestore.instance
        .collection("NewBookOrder")
        .doc(orderId)
        .update({"ProductionDone": status});
  }

  static ChangeDeliveryStatus(String? orderId, bool status) async {
    await FirebaseFirestore.instance
        .collection("NewBookOrder")
        .doc(orderId)
        .update({"Delivered": status});
  }
}

class OrderModel {
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
