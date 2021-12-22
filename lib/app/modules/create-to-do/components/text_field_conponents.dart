import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/utils/helpers/maxlinetype_enum.dart';

class TextFieldComponents extends StatelessWidget {
  const TextFieldComponents({
    Key? key,
    this.label,
    this.obsureText,
    required this.controller,
    required this.lineType,
  }) : super(key: key);

  final String? label;
  final bool? obsureText;
  final MaxLineType lineType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? 'label',
          style: defaultFontsStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        const SizedBox(
          height: mainSpacing,
        ),
        TextField(
          controller: controller,
          onSubmitted: (value) {
            controller.text = value;
          },
          onChanged: (value) {
            controller.text = value;
          },
          maxLines: lineType == MaxLineType.text ? 3 : 1,
          obscureText: obsureText ?? false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
          ),
        ),
        const SizedBox(
          height: mainSpacing,
        )
      ],
    );
  }
}
