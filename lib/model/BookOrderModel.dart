import 'package:cloud_firestore/cloud_firestore.dart';

class Order {

  String CustomerName;
  String MobileNumber;
  String Advance;
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
       CustomerName : snapshot["CustomerName"] ?? "NO DATA",
     Advance : snapshot["Advance"] ?? "NO DATA",
     MobileNumber : snapshot["MobileNumber"] ?? "NO DATA",
     Note : snapshot["Note"] ?? "NO DATA",
     OrderBookDate : snapshot["OrderBookDate"] ?? "NO DATA",
     OrderDelivaryDate : snapshot["OrderBookDate"] ?? "NO DATA",
     // items : snapshot["items"],
     items : [],
   );
  }
}



class OrderItem{

  String ProductCategory;
  String ProductName;


  OrderItem({

    required this.ProductCategory,
    required this.ProductName,


  });

  Map<String , dynamic> toJson()=>{
    "ProductCategory" : ProductCategory,
    "ProductName" : ProductName,

  };



  static OrderItem fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return OrderItem(
      ProductCategory : snapshot["ProductCategory"] ?? "NO DATA",
      ProductName : snapshot["ProductName"] ?? "NO DATA",
    );
  }

}