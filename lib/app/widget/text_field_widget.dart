import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/utils/helpers/maxlinetype_enum.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.readOnly,
    this.label,
    this.obsureText = false,
    this.onTap,
    required this.controller,
    required this.lineType,
  }) : super(key: key);

  final String? label;
  final bool? obsureText;
  final MaxLineType lineType;
  final TextEditingController controller;
  final Function? onTap;
  final bool? readOnly;

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
        TextFormField(
          onTap: () => onTap!.call(),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return '$label tidak boleh kosong';
            }
            if (obsureText == false) {
              if (value.contains('_')) {
                return '$label tidak boleh menggunakan underscore "_"';
              }
            }
            if (value.length <= 2) {
              return '$label harus lebih banyak dari dua huruf';
            }

            return null;
          },
          onFieldSubmitted: (value) {
            controller.text = value;
            // .splitMapJoin((value.characters.first),
            //     onMatch: (m) => m[0]!.toUpperCase().toString(),
            //     onNonMatch: (m) => m[0].toUpperCase());
          },
          style: defaultFontsStyle(),
          readOnly: readOnly ?? false,
          maxLines: lineType == MaxLineType.text ? 3 : 1,
          obscureText: obsureText ?? false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
