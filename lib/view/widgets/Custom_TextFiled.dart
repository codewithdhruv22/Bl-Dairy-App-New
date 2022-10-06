import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const CustomTextFiled(
      {Key? key, required this.textEditingController, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.05,
      width: size.width - 15,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }
}
