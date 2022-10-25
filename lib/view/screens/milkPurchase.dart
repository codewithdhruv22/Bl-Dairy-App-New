import 'package:bl_dairy_app/controller/milkPurchaseController.dart';
import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:bl_dairy_app/model/milkPurchaseModel.dart';
import 'package:bl_dairy_app/view/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
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
double fatRate = 0.0;
int suppMobNo = 0;

class _MilkPurchaseScreenState extends ConsumerState<MilkPurchaseScreen> {
  File? _image;

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
      Get.snackbar("Whtsapp Installation Infor", value.toString());
    });
  }

  Future<void> shareFile(String text, String phoneNo) async {
    await getImage();
    Directory? directory = await getExternalStorageDirectory();
    print('${directory!.path} / ${_image!.path}');
    await isInstalled();
    await WhatsappShare.shareFile(
      text: text,
      phone: '91$phoneNo',
      filePath: ["${_image!.path}"],
    );
  }

  Future getImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? _pickedFile =
          (await _picker.pickImage(source: ImageSource.camera));

      if (_pickedFile != null) {
        // getting a directory path for saving
        final directory = await getExternalStorageDirectory();

        // copy the file to a new path
        await _pickedFile.saveTo('${directory!.path}/image1.png');
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
                      asyncItems: (String filter) =>
                          milkSupplierController.fetchOneLedger(filter),
                      itemAsString: (MilkSupplierModel u) => u.Name,
                      onChanged: (MilkSupplierModel? data) {
                        setState(() {
                          print("FAT RATE IS HERE");
                          print(data!.Name);
                          print(data.FatRate);
                          suppNameEdCont.text = data.Name;
                          fatRate += double.parse(data.FatRate.toString());
                          suppMobNo = int.parse(data.Mobile);
                        });
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration:
                            InputDecoration(labelText: "Select Supplier"),
                      ),
                    ),

//                 SearchField(
//                   suggestionState: Suggestion.expand,
//                   textInputAction: TextInputAction.next,
// controller: suppNameEdCont,
// suggestions: searchList.map((e) => SearchFieldListItem(e.Name)).toList(),
//                   suggestionAction: SuggestionAction.unfocus,
//                   onSuggestionTap: (value){
//
//                   },
//                 ),
                    const SizedBox(
                      height: 10,
                    ),
                    // TextFieldSearch(
                    //
                    //   controller : suppNameEdCont,
                    //   initialList: searchList,
                    //   itemsInView: 10,
                    //   label: 'Supplier Name',
                    //   decoration: const InputDecoration(
                    //     labelText: 'Supplier Name',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: DropdownButton<String>(
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                ShiftVal = value!;
                              });
                            },
                            hint: const Text('Choose Shift'),
                            items: shiftlist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: ShiftVal,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),

                            // decoration: const InputDecoration(
                            //   contentPadding:
                            //       EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            //   labelStyle: TextStyle(fontSize: 14),
                            //   labelText: 'Milk Type',
                            //   border: OutlineInputBorder(),
                            // ),
                            // controller: advancePaymentController,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () => _selectDate(ref),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                  style: TextStyle(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton<String>(
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                MilkTypeVal = value!;
                              });
                            },
                            hint: const Text('Milk Type'),
                            items: milktyplist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: MilkTypeVal,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),

                            // decoration: const InputDecoration(
                            //   contentPadding:
                            //       EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            //   labelStyle: TextStyle(fontSize: 14),
                            //   labelText: 'Milk Type',
                            //   border: OutlineInputBorder(),
                            // ),
                            // controller: advancePaymentController,
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
                              setState(() {
                                totalAmnt = double.parse(fatEdCont.text) *
                                    fatRate *
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: qtyEdCont,
                            onChanged: (value) {
                              setState(() {
                                totalAmnt = double.parse(fatEdCont.text) *
                                    fatRate *
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

                          shareFile(
                            "Bill of Milk Purchase\nName- ${suppNameEdCont.text}\nShift - ${ShiftVal}"
                            "\nMilk Type - ${MilkTypeVal}\nMilk Qty - ${double.parse(qtyEdCont.text)}\nFat - ${fatEdCont.text}"
                            "\nSNF Value - ${snfEdCont.text}\nTotal Amount - ${totalAmnt}",
                            suppMobNo.toString(),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Sending Whatsapp Message')),
                          );

                          fatRate = 0;
                          fatEdCont.clear();
                          qtyEdCont.clear();
                          milkTypeEdCont.clear();
                          shiftEdCont.clear();
                          snfEdCont.clear();
                          suppNameEdCont.clear();
                          totalAmnt = 0;

                          setState(() {});
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
