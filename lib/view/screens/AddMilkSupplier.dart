import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../constants/Theme.dart';

class AddMilkSupplierScreen extends StatefulWidget {
  AddMilkSupplierScreen({Key? key}) : super(key: key);

  @override
  State<AddMilkSupplierScreen> createState() => _AddMilkSupplierScreenState();
}

// variable added by ashvin
final _formKey = GlobalKey<FormState>();
List<String> list = <String>['Cow', 'Buffalow'];
String dropdownValue = list.first;
String RateType = "Fat Rate Based";

TextEditingController NameEditingController = TextEditingController();
TextEditingController MobNOEditingController = TextEditingController();
TextEditingController MilkTypeEditingController = TextEditingController();
TextEditingController RateEditingController = TextEditingController();
TextEditingController SNFDedPriceEditingController = TextEditingController();
TextEditingController FatDedPriceEditingController = TextEditingController();
TextEditingController AdhrNoEditingController = TextEditingController();
TextEditingController AdressEditingController = TextEditingController();

class _AddMilkSupplierScreenState extends State<AddMilkSupplierScreen> {
  String? RateLabelText = "Basic Rate";

  @override
  void initState() {
    super.initState();
    SNFDedPriceEditingController.text = "0";
    FatDedPriceEditingController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
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
                      icon: Icon(
                        FeatherIcons.arrowLeft,
                        color: MyColors.black,
                      ),
                    ),
                    Text(
                      'Add Supplier',
                      style: TextStyle(fontSize: 15),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: NameEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      // controller: fullNameController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: MobNOEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Number';
                        }
                        return null;
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Mobile Number',
                        helperText: 'Without Country Code',
                        border: OutlineInputBorder(),
                      ),
                      // controller: mobileNumberController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton<String>(
                            hint: Text('Milk Type'),
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                print(value);
                                dropdownValue = value!;
                                if (value == "Buffalow") {
                                
                                    RateLabelText = "Fat Rate";
                                  
                                 
                                }else{
                                    RateLabelText = "Basic Rate";
                                }

                                  MilkTypeEditingController.text = value;
                                });
                              },
                              // decoration:  InputDecoration(
                              //   contentPadding:
                              //       EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                              //   labelStyle: TextStyle(fontSize: 14),
                              //   labelText: 'Milk Type',
                              //   border: OutlineInputBorder(),
                              // ),
                              // controller: advancePaymentController,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: RateEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Fill Rate';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              labelStyle: TextStyle(fontSize: 14),
                              labelText: RateLabelText,
                              border: OutlineInputBorder(),
                            ),
                            // controller: advancePaymentController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: AdhrNoEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Number';
                        }
                        return null;
                      },
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Aadhar Number',
                        border: OutlineInputBorder(),
                      ),
                      // controller: mobileNumberController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: AdressEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      // controller: remarkController,
                    ),
                        SizedBox(
                      height: 12,
                    ),
                    dropdownValue == "Cow"
                        ? Column(
                            children: [
                              TextFormField(
                                controller: SNFDedPriceEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Fill Rate';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  labelStyle: TextStyle(fontSize: 14),
                                  labelText: "SNF Deduction",
                                  border: OutlineInputBorder(),
                                ),
                                // controller: advancePaymentController,
                              ),
                                  SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: FatDedPriceEditingController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Fill Rate';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 15),
                                  labelStyle: TextStyle(fontSize: 14),
                                  labelText: "Fat Deduction",
                                  border: OutlineInputBorder(),
                                ),
                                // controller: advancePaymentController,
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            milkSupplierController
                                .addNewMilkSupplier(MilkSupplierModel(
                              Rate: RateEditingController.text,
                              MilkType: dropdownValue,
                              Mobile: MobNOEditingController.text,
                              Name: NameEditingController.text,
                              Village: AdressEditingController.text,
                              isCowMilk: dropdownValue == "Cow" ? true : false,
                              SNFDedPrice: SNFDedPriceEditingController.text,
                              FatDedPrice: FatDedPriceEditingController.text,
                            ));

                            RateEditingController.clear();
                            MilkTypeEditingController.clear();
                            MobNOEditingController.clear();
                            NameEditingController.clear();
                            AdressEditingController.clear();
                            AdhrNoEditingController.clear();
                            SNFDedPriceEditingController.text = "0";
                            FatDedPriceEditingController.text = "0";
                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Supplier Added')),
                            );
                          }
                        },
                        child: Text("Add Ledger"))
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
