import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MilkPurchaseController {
  static addMilkPurchase(MilkPurchaseModel milkPurchaseModel) async {
    await FirebaseFirestore.instance
        .collection("NewMilkPurchase2")
        .add(milkPurchaseModel.toJson())
        .then((_) {
      print("MILK PURCHASED");
    });
  }

  static Future<List<MilkPurchaseModel>?> fetchAllMilkPurchase() async {
    List<MilkPurchaseModel> all_milkPurchase = [];
    await FirebaseFirestore.instance
        .collection("NewMilkPurchase2")
        .orderBy("Date")
        .get()
        .then((querSnapshots) {
      querSnapshots.docs.forEach((order) {
        all_milkPurchase.add(MilkPurchaseModel.fromSnap(order));
      });
    });
    return all_milkPurchase;
  }

  static Future<List<MilkPurchaseModel>> allMilkPurchaseByDate(
      Timestamp timestamp) async {
    print(Timestamp.now().toDate());
    List<MilkPurchaseModel> result_milkPurchase = [];
    await FirebaseFirestore.instance
        .collection("NewMilkPurchase2")
        .orderBy("Date", descending: true)
        .get()
        .then((querSnapshots) {
      querSnapshots.docs.forEach((order) {
        print("DECISION");
        int day = MilkPurchaseModel.fromSnap(order).Date.toDate().day;
        int month = MilkPurchaseModel.fromSnap(order).Date.toDate().month;
        int year = MilkPurchaseModel.fromSnap(order).Date.toDate().year;

        int queryDay = timestamp.toDate().day;
        int queryMonth = timestamp.toDate().month;
        int queryYear = timestamp.toDate().year;

        if (day == queryDay && month == queryMonth && year == queryYear) {
          result_milkPurchase.add(MilkPurchaseModel.fromSnap(order));
        }
        ;
      });
    });
    print("OPERATION SUCCESSFULl");
    print(result_milkPurchase);
    return result_milkPurchase;
  }

  static Future<List<MilkPurchaseModel>> allMilkPurchaseByThisWeek() async {
    print("CALLING");

    var date = DateTime.now();
    var oneWeekPreviousDate = new DateTime(date.year, date.month, date.day - 7);

    print("ONE WEEK PREVIOUS DATE");
    print(oneWeekPreviousDate);

    List<MilkPurchaseModel> result_milkPurchase = [];
    await FirebaseFirestore.instance
        .collection("NewMilkPurchase2")
        .orderBy("Date", descending: true)
        .get()
        .then((querSnapshots) {
      int j = 8;
      for (var item in querSnapshots.docs) {
        print(
            "***************************************************************************");

        if (MilkPurchaseModel.fromSnap(item)
                .Date
                .compareTo(Timestamp.fromDate(oneWeekPreviousDate)) >
          
            0) {


              print(
              "////////////////////////////////////////////////////////////////");



          print(" I AM NEW LOGINC");
          print(MilkPurchaseModel.fromSnap(item).SupplierName);
          result_milkPurchase.add(MilkPurchaseModel.fromSnap(item));
          print(
              "////////////////////////////////////////////////////////////////");
        }

        // print("HELLO JI");
        // print(MilkPurchaseModel.fromSnap(item).Date.toDate().weekday);
        // print(j);

        // print(MilkPurchaseModel.fromSnap(item).Date.toDate().weekday > j);
        // if (MilkPurchaseModel.fromSnap(item).Date.toDate().weekday <= j) {
        //   print("WEEKDAY PRINTING");
        //   // print(Timestamp.now().toDate().weekday);

        //   print(MilkPurchaseModel.fromSnap(item).Date.toDate().weekday);
        //   print(MilkPurchaseModel.fromSnap(item).SupplierName);
        //   // if()
        //   result_milkPurchase.add(MilkPurchaseModel.fromSnap(item));
        // } else {
        //   break;
        // }

        // j = MilkPurchaseModel.fromSnap(item).Date.toDate().weekday;

        // print(
        //     "***************************************************************************");
      }
    });

    print(result_milkPurchase);
    return result_milkPurchase;
  }

  static Future<List<MilkPurchaseModel>> allMilkPurchaseByThisMonth() async {
    print("CALLING");
    List<MilkPurchaseModel> result_milkPurchase = [];
    await FirebaseFirestore.instance
        .collection("NewMilkPurchase2")
        .orderBy("Date", descending: true)
        .get()
        .then((querSnapshots) {
      int currentMonth = DateTime.now().month;
      int currentYear = DateTime.now().year;
      for (var item in querSnapshots.docs) {
        print("NEW MILK PURCHASE ITEMS DATA");
        print(item.data());
        final purchaseDate = MilkPurchaseModel.fromSnap(item).Date.toDate();
        print("PURCHASE DATE AND MONTH DETAILS");
        print(purchaseDate.month);
        print(currentMonth);
        print(purchaseDate.month == currentMonth &&
            purchaseDate.year == currentYear);
        if (purchaseDate.month == currentMonth &&
            purchaseDate.year == currentYear) {
          result_milkPurchase.add(MilkPurchaseModel.fromSnap(item));
        }
      }
    });
    print("I AM MONTH MILK PURCHASE");
    print(result_milkPurchase);
    return result_milkPurchase;
  }

  static Future<List<String>> fetchSearchMilkPurchase(String query) async {
    print("CALLING");
    List<String> result_milkPurchase = [];
    await FirebaseFirestore.instance
        .collection("NewMilkPurchase2")
        .where("SupplierName", isGreaterThanOrEqualTo: query)
        .get()
        .then((querSnapshots) {
      querSnapshots.docs.forEach((item) {
        result_milkPurchase.add(MilkPurchaseModel.fromSnap(item).SupplierName);
      });
    });

    return result_milkPurchase;
  }
}
