import 'package:bl_dairy_app/controller/milkPurchaseController.dart';
import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/Theme.dart';
import 'package:get/get.dart';

class MilkPurchaseScreen extends ConsumerStatefulWidget {
  const MilkPurchaseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MilkPurchaseScreen> createState() => _MilkPurchaseScreenState();
}

final _formKey = GlobalKey<FormState>();
final List<MilkSupplierModel> searchList = [];
const List<String> milktyplist = <String>['Cow', 'Buffalow'];
const List<String> shiftlist = <String>['Morning', 'Evening'];
String MilkTypeVal = milktyplist.first;
String ShiftVal = shiftlist.first;

TextEditingController suppNameEdCont = TextEditingController();
TextEditingController shiftEdCont = TextEditingController();
TextEditingController milkTypeEdCont = TextEditingController();
TextEditingController fatEdCont = TextEditingController();
TextEditingController snfEdCont = TextEditingController();
TextEditingController qtyEdCont = TextEditingController();

double totalAmnt = 0.0;
double Rate = 0.0;
double SNFDedPrice = 0.0;
double FatDedPrice = 0.0;

int suppMobNo = 0;

double fatThreshold = 3.5;
double snfThreshold = 8.5;

class _MilkPurchaseScreenState extends ConsumerState<MilkPurchaseScreen> {
  File? _image;
  String chooseImgFrom = 'Camera';
  final _dateProvider = StateProvider<DateTime>((ref) {
    return DateTime.now();
  });
  void _selectDate(WidgetRef ref) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: ref.watch(_dateProvider),
      lastDate: DateTime(2101),
      helpText: 'Select a date',
      firstDate: DateTime(2018),
    );
    if (newDate != null) {
      ref.read(_dateProvider.notifier).state = newDate;
    }
  }

  @override
  void initState() {
    suppNameEdCont.addListener(() async {
      final String value = suppNameEdCont.value.text;
      searchList.clear();
      searchList.addAll(await milkSupplierController.fetchOneLedger(value));

      searchList.toSet().toList();

      // YOUR CODE
    });
    super.initState();
  }

  Future<void> isInstalled() async {
    await WhatsappShare.isInstalled(package: Package.whatsapp).then((value) {
      Get.snackbar("Whatsapp Not Found", "Please install Whatsapp First.");
    });
  }

  Future<void> shareFile(String text, String phoneNo, String imgSource) async {
    await getImage(imgSource);
    Directory? directory = await getExternalStorageDirectory();
    print('${directory!.path} / ${_image!.path}');
    await isInstalled();
    await WhatsappShare.shareFile(
      text: text,
      phone: '91$phoneNo',
      filePath: [(_image!.path)],
    );
  }

  Future getImage(String imgSrc) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? pickedFile = (await picker.pickImage(
          source:
              imgSrc == "Camera" ? ImageSource.camera : ImageSource.gallery));

      if (pickedFile != null) {
        // getting a directory path for saving
        final directory = await getExternalStorageDirectory();

        // copy the file to a new path
        await pickedFile.saveTo('${directory!.path}/image1.png');
        _image = File('${directory.path}/image1.png');
      }
    } catch (er) {
      print(er);
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = ref.watch(_dateProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 4,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        FeatherIcons.arrowLeft,
                        color: MyColors.black,
                      ),
                    ),
                    const Text(
                      'Milk Purchase',
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    DropdownSearch<MilkSupplierModel>(
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'Select A Supplier';
                        }
                        return null;
                      },
                      asyncItems: (String filter) =>
                          milkSupplierController.fetchOneLedger(filter),
                      itemAsString: (MilkSupplierModel u) => u.Name,
                      onChanged: (MilkSupplierModel? data) {
                        setState(() {
                          print("FAT RATE IS HERE");
                          print(data!.Name);
                          print(data.Rate);
                          print(data.SNFDedPrice);
                          print(data.FatDedPrice);
                          suppNameEdCont.text = data.Name;

                          SNFDedPrice = double.parse(data.SNFDedPrice);
                          FatDedPrice = double.parse(data.FatDedPrice);
                          Rate = double.parse(data.Rate.toString());
                          suppMobNo = int.parse(data.Mobile);

                          totalAmnt = MilkTypeVal == "Cow"
                              ? SNFDedPrice.toString() == "0.0"
                                  ? Rate * double.parse(qtyEdCont.text)
                                  : (Rate +
                                          ((double.parse(snfEdCont.text) -
                                                  snfThreshold) *
                                              SNFDedPrice *
                                              10) +
                                          ((double.parse(fatEdCont.text) -
                                                  fatThreshold) *
                                              FatDedPrice *
                                              10)) *
                                      double.parse(qtyEdCont.text)
                              : double.parse(fatEdCont.text) *
                                  Rate *
                                  double.parse(qtyEdCont.text);
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(gapPadding: 4.0),
                            labelText: "  Select Supplier",
                            contentPadding: EdgeInsets.all(0)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(181, 136, 136, 136),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              borderRadius: BorderRadius.circular(10),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  ShiftVal = value!;
                                });
                              },
                              hint: const Text('Choose Shift '),
                              items: shiftlist.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: ShiftVal,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(
                                color: MyColors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(ref),
                            child: Container(
                              height: 49,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.defaultColor,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  "${date.day}-${date.month}-${date.year}",
                                  // "${date.day}-${date.month}-${date.year}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(181, 136, 136, 136),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButton<String>(
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  MilkTypeVal = value!;
                                });
                              },
                              hint: const Text('Milk Type'),
                              items: milktyplist.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: MilkTypeVal,
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              underline: Container(),
                              style: const TextStyle(
                                color: MyColors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: fatEdCont,
                            onChanged: (value) {
                              print("SNF VALUE");
                              print(SNFDedPrice);
                              print(SNFDedPrice.toString() == "0");
                              setState(() {
                                totalAmnt = MilkTypeVal == "Cow"
                                    ? SNFDedPrice.toString() == "0.0"
                                        ? Rate * double.parse(qtyEdCont.text)
                                        : (Rate +
                                                ((double.parse(snfEdCont.text) -
                                                        snfThreshold) *
                                                    SNFDedPrice *
                                                    10) +
                                                ((double.parse(fatEdCont.text) -
                                                        fatThreshold) *
                                                    FatDedPrice *
                                                    10)) *
                                            double.parse(qtyEdCont.text)
                                    : double.parse(fatEdCont.text) *
                                        Rate *
                                        double.parse(qtyEdCont.text);
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill Rate';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: 'Fat',
                              border: OutlineInputBorder(),
                            ),
                            // controller: advancePaymentController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              print(SNFDedPrice.toString() == "0");
                              setState(() {
                                totalAmnt = MilkTypeVal == "Cow"
                                    ? SNFDedPrice.toString() == "0.0"
                                        ? Rate * double.parse(qtyEdCont.text)
                                        : (Rate +
                                                ((double.parse(snfEdCont.text) -
                                                        snfThreshold) *
                                                    SNFDedPrice *
                                                    10) +
                                                ((double.parse(fatEdCont.text) -
                                                        fatThreshold) *
                                                    FatDedPrice *
                                                    10)) *
                                            double.parse(qtyEdCont.text)
                                    : double.parse(fatEdCont.text) *
                                        Rate *
                                        double.parse(qtyEdCont.text);
                              });
                            },

                            keyboardType: TextInputType.number,
                            controller: snfEdCont,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill SNF Value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: 'SNF Value',
                              border: OutlineInputBorder(),
                            ),
                            // controller: advancePaymentController,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: qtyEdCont,
                            onChanged: (value) {
                              print(SNFDedPrice.toString() == "0");
                              setState(() {
                                totalAmnt = MilkTypeVal == "Cow"
                                    ? SNFDedPrice.toString() == "0.0"
                                        ? Rate * double.parse(qtyEdCont.text)
                                        : (Rate +
                                                ((double.parse(snfEdCont.text) -
                                                        snfThreshold) *
                                                    SNFDedPrice *
                                                    10) +
                                                ((double.parse(fatEdCont.text) -
                                                        fatThreshold) *
                                                    FatDedPrice *
                                                    10)) *
                                            double.parse(qtyEdCont.text)
                                    : double.parse(fatEdCont.text) *
                                        Rate *
                                        double.parse(qtyEdCont.text);
                              });
                            },
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill Value';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: 'Quantity',
                              border: OutlineInputBorder(),
                            ),
                            // controller: advancePaymentController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "TOTAL PRICE - ${double.parse((totalAmnt).toStringAsFixed(2))}")),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            MilkPurchaseController.addMilkPurchase(
                                MilkPurchaseModel(
                              Date: Timestamp.fromDate(date),
                              fat: double.parse(fatEdCont.text),
                              milkQty: double.parse(qtyEdCont.text),
                              milkType: MilkTypeVal,
                              shift: ShiftVal,
                              snfVal: double.parse(snfEdCont.text),
                              SupplierName: suppNameEdCont.text,
                              totalAmnt: totalAmnt,
                            ));

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Milk Purchase Entry Successful')),
                            );

                            // whatsapp://send?phone=$contact&text=Hi, I need some help
                            // await launchUrl(Uri.parse(
                            //     "whatsapp://send?phone=+91${suppMobNo}&text=Bill of Milk Purchase\nName- ${suppNameEdCont.text}\nShift - ${ShiftVal}"
                            //     "\nMilk Type - ${MilkTypeVal}\nMilk Qty - ${double.parse(qtyEdCont.text)}\nFat - ${fatEdCont.text}"
                            //     "\nSNF Value - ${snfEdCont.text}\nTotal Amount - ${totalAmnt}"));

                            await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title:
                                    const Text("Upload Image Of Fat Machine"),
                                content: const Text("Choose Image From :- "),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        chooseImgFrom = 'Camera';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Camera"),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        chooseImgFrom = 'Gallery';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("Gallery"),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            shareFile(
                                "Bill of Milk Purchase\nName- ${suppNameEdCont.text}\nShift - $ShiftVal"
                                "\nMilk Type - $MilkTypeVal\nMilk Qty - ${double.parse(qtyEdCont.text)}\nFat - ${fatEdCont.text}"
                                "\nSNF Value - ${snfEdCont.text}\nTotal Amount - $totalAmnt",
                                suppMobNo.toString(),
                                chooseImgFrom);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('Sending Whatsapp Message')),
                            );

                            Rate = 0;
                            fatEdCont.clear();
                            qtyEdCont.clear();
                            milkTypeEdCont.clear();
                            shiftEdCont.clear();
                            snfEdCont.clear();
                            suppNameEdCont.clear();
                            totalAmnt = 0;

                            setState(() {});
                          }
                        },
                        child: const Text("Complete"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
