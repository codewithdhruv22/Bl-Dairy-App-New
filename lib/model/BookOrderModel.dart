import 'package:cloud_firestore/cloud_firestore.dart';

import '../view/screens/book_order.dart';

class Order {

  String CustomerName;
  String MobileNumber;
  String Advance;
  String Note;
  Timestamp OrderBookDate;
  Timestamp OrderDelivaryDate;


  Order({

    required this.CustomerName,
    required this.MobileNumber,
    required this.Advance,
    required this.Note,
    required this.OrderBookDate,
    required this.OrderDelivaryDate,

  });



  Map<String , dynamic> toJson()=> {
    "CustomerName" : CustomerName,
    "Advance": Advance,
    "MobileNumber" : MobileNumber,
    "Note" : Note,
    "OrderBookDate" : OrderBookDate,
    "OrderDelivaryDate" : OrderDelivaryDate,

  };



  static Order fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    print("I AM ORDER");
    print(snapshot["items"]);
   return Order(
       CustomerName : snapshot["CustomerName"] ?? "NO DATA",
     Advance : snapshot["Advance"] ?? "NO DATA",
     MobileNumber : snapshot["MobileNumber"] ?? "NO DATA",
     Note : snapshot["Note"] ?? "NO DATA",
     OrderBookDate : snapshot["OrderBookDate"] ,
     OrderDelivaryDate : snapshot["OrderDelivaryDate"],


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