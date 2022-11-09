import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String SupplierName;
  double PaidAmount;
  String Note;

  PaymentModel(
      {required this.SupplierName,
      required this.PaidAmount,
      required this.Note});

  Map<String, dynamic> toJson() =>
      {"SupplierName": SupplierName, "PaidAmount": PaidAmount, "Note": Note};

  static PaymentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PaymentModel(
        SupplierName: snapshot["SupplierName"] ?? "NO DATA",
        PaidAmount: snapshot["PaidAmount"] ?? "NO DATA",
        Note: snapshot["Note"] ?? "No Notes!");
  }
}