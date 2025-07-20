import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.labelText,
    required this.value,
    this.obscure = false,
  });
  final String labelText;
  Function(String)? value;
  bool? obscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(200, 200, 200, 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          obscureText: obscure!,
          validator: (data) {
            if (data!.isEmpty) {
              return 'field required';
            }
          },
          onChanged: value,
          decoration: InputDecoration(
            label: Text(
              labelText,
              style: TextStyle(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
