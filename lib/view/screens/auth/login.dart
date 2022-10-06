import 'package:flutter/material.dart';
import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: MyColors.primary),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(99, 255, 255, 255),
                    ),
                    padding: EdgeInsets.all(0),
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Icon(
                        FeatherIcons.logIn,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'login to auto backup your data securly.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              cursorColor: MyColors.primary,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(
                  FeatherIcons.phone,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: MyColors.primary),
              icon: Icon(FeatherIcons.send),
              label: Text("Send OTP"),
            )
          ],
        ),
      )),
    );
  }
}
