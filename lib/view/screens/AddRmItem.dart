import 'package:bl_dairy_app/controller/RmController.dart';
import 'package:flutter/material.dart';

import '../../constants/Theme.dart';

class AddNewRm extends StatefulWidget {
  AddNewRm({super.key});

  @override
  State<AddNewRm> createState() => _AddNewRmState();
}

class _AddNewRmState extends State<AddNewRm> {
  TextEditingController newRmNameController = TextEditingController();

  TextEditingController newRmPriceController = TextEditingController();

  String RmType = "Raw Material";

  List<String> rmTypeList = ["Raw Material", "Sweet", "Namkeen", "Dryfruit"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Raw Material")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: newRmNameController,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Fill Name';
                }
                return null;
              },
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                labelStyle: TextStyle(fontSize: 14),
                labelText: 'Raw Material Name',
                border: OutlineInputBorder(),
              ),
              // controller: advancePaymentController,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: newRmPriceController,
              onChanged: (value) {},
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
                labelText: 'Raw Material Price',
                border: OutlineInputBorder(),
              ),
              // controller: advancePaymentController,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
                    RmType = value!;
                  });
                },
                hint: const Text('Raw Material Type'),
                items: rmTypeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: RmType,
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  RmController.addNewRm(
                          RmName: newRmNameController.text,
                          RmPrice: double.parse(newRmPriceController.text),
                          RmType: RmType)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '${newRmNameController.text} Added Successfully')),
                    );

                    newRmNameController.clear();
                    newRmPriceController.clear();
                    RmType = "Raw Material";
                    setState(() {
                      
                    });
                  });
                },
                child: Text("Add New Raw Material"))
          ]),
        ),
      ),
    );
  }
}
