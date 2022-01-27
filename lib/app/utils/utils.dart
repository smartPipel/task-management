import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';

showSnackBar(BuildContext context, String message, String result) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: result == 'false' ? Colors.redAccent : Colors.green,
      content: SizedBox(
        height: 30,
        child: Center(
            child: Text(
          message,
          style: defaultFontsStyle(),
        )),
      ),
    ),
  );
}
