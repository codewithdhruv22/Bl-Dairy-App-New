import 'package:cloud_firestore/cloud_firestore.dart';

class Order {

  String CustomerName;
  String MobileNumber;
  int Advance;
  String Note;
  String OrderBookDate;
  String OrderDelivaryDate;
  List<OrderItem> items;

  Order({

    required this.CustomerName,
    required this.MobileNumber,
    required this.Advance,
    required this.Note,
    required this.OrderBookDate,
    required this.OrderDelivaryDate,
    required this.items
  });



  Map<String , dynamic> toJson()=> {
    "CustomerName" : CustomerName,
    "Advance": Advance,
    "MobileNumber" : MobileNumber,
    "Note" : Note,
    "OrderBookDate" : OrderBookDate,
    "OrderDelivaryDate" : OrderDelivaryDate,
    "items" : items
  };



  static Order fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
   return Order(
       CustomerName : snapshot["CustomerName"],
     Advance : snapshot["Advance"],
     MobileNumber : snapshot["MobileNumber"],
     Note : snapshot["Note"],
     OrderBookDate : snapshot["OrderBookDate"],
     OrderDelivaryDate : snapshot["OrderBookDate"],
     items : snapshot["items"],
   );
  }
}



class OrderItem{

  String itemName;
  int itemQty;
  int itemRate;

  OrderItem({

    required this.itemName,
    required this.itemQty,
    required this.itemRate

  });

  Map<String , dynamic> toJson()=>{
    "itemName" : itemName,
    "itemQty" : itemQty,
    "itemNate" : itemRate
  };


}