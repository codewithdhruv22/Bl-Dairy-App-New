import 'package:bl_dairy_app/controller/milkSupplierController.dart';
import 'package:bl_dairy_app/model/ledgerModel.dart';
import 'package:flutter/material.dart';

class AddMilkSupplierScreen extends StatefulWidget {
  const AddMilkSupplierScreen({Key? key}) : super(key: key);

  @override
  State<AddMilkSupplierScreen> createState() => _AddMilkSupplierScreenState();
}

// variable added by ashvin
final _formKey = GlobalKey<FormState>();
const List<String> list = <String>['Cow', 'Buffalow'];
String dropdownValue = list.first;

class _AddMilkSupplierScreenState extends State<AddMilkSupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                // controller: fullNameController,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Number';
                  }
                  return null;
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Mobile Number',
                  helperText: 'Without Country Code',
                  border: OutlineInputBorder(),
                ),
                // controller: mobileNumberController,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: DropdownButton<String>(
                      hint: const Text('Milk Type'),
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fill Rate';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Fat Rate',
                        border: OutlineInputBorder(),
                      ),
                      // controller: advancePaymentController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Remark',
                  border: OutlineInputBorder(),
                ),
                // controller: remarkController,
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Supplier Added')),
                      );
                    }
                    milkSupplierController.addNewMilkSupplier(MilkSupplierModel(
                        FatRate: "2.5",
                        MilkType: "Cow",
                        Mobile: "9999888",
                        Name: "DEMO NAME",
                        Village: "DEMO VILLAGE"));
                  },
                  child: const Text("Add Ledger"))
            ],
          ),
        ),
      ),
    );
  }
}
