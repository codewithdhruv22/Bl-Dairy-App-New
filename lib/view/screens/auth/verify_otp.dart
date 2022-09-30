import 'package:flutter/material.dart';
import 'package:bl_dairy_app/view/constants/Theme.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class verify_otp extends StatelessWidget {
  const verify_otp({super.key});

  @override
  Widget build(BuildContext context) {
    var number = "9522821568";
    OtpFieldController otpController = OtpFieldController();
    var timer = '22 sec';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(149),
        child: AppBar(
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
              decoration: BoxDecoration(color: MyColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    icon: Icon(
                      FeatherIcons.arrowLeft,
                      color: MyColors.white,
                    ),
                    label: Text(
                      "Change",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Row(
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
                            FeatherIcons.key,
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
                            'Verify OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Row(children: [
                            Text(
                              'We have sent you a One Time Passowrd On +91 $number |',
                              style: TextStyle(
                                color: MyColors.white,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Respond to button press
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ])
                        ],
                      )
                    ],
                  ),
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
            OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.center,
                fieldWidth: 45,
                fieldStyle: FieldStyle.underline,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              'Resend OTP in $timer sec Via',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: MyColors.defaultColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    style: ElevatedButton.styleFrom(),
                    icon: Icon(
                      FeatherIcons.send,
                      color: MyColors.defaultColor,
                    ),
                    label: Text(
                      "Resend",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: MyColors.defaultColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary),
                    icon: Icon(FeatherIcons.checkCircle),
                    label: Text("verify"),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
