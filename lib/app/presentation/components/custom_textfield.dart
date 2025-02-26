import 'package:flutter/material.dart';
import 'package:flutter_web/app/core/core.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.text,
    this.keyboardType,
    this.maxLines = 1,
  });

  factory CustomTextField.label({
    Key? key,
    required TextEditingController controller,
    required String text,
    required String hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return CustomTextField(
      key: key,
      controller: controller,
      text: text,
      hintText: hintText,
      keyboardType: keyboardType,
    );
  }

  final TextEditingController controller;
  final String? text;
  final String hintText;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text != null
            ? Text(
                text!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox(),
        text != null ? 8.sbh() : const SizedBox(),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: 8.br(),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
