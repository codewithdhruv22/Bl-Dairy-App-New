import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String label;
  final String value;

  const CustomTextFiled({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: MyColors.defaultColor),
        ),
        Text(value)
      ],
    );
  }
}
